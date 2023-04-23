//
//  EventViewModel.swift
//  event-workshop
//
//  Created by ODC on 13/4/2023.
//

import Foundation
import Combine


enum GetAllEventsState
{
    
    case loading
    case emptyList
    case success
    case failure
    
}

enum GetEventByIdState
{
    
    case loading
    case success
    case failure
    
}


class EventViewModel:ObservableObject
{
    
    @Published var upcomingEvents:[Event] = []
    
    @Published var nearByEvents:[Event] = []

    @Published var upcomingEventsIsLoading:Bool = false
    
    
    @Published var getAllUpcomingEventsState:GetAllEventsState = .loading
    @Published var allUpcomingEvents:[Event] = []
    
    
    @Published var getEventByIdState:GetEventByIdState = .loading
    @Published var eventDetail:EventDetail = EventDetail()
    
    
    @Published var selectedCategories: [CategoriesFilterType] = [.All]
    @Published var selectedDateFilter:DateTimeFilterType = .Today
    @Published var priceFilter:Double = 0

    
    @Published var nearbyEventsIsLoading:Bool = false
    
    @Published var getEventByIdIsLoading = false
    

    private var cancellableSet:Set<AnyCancellable> = []

    
    var eventService:EventService
    
    init(eventService:EventService)
    {
        self.eventService = eventService
        
        self.getSavedFilters()
        self.updateFilters()
        
    }
    
    
    
    func getSavedFilters()
    {
        
        
        self.selectedCategories = LocalPreferences.shared.categoryFilter.split(separator: ",").map{
            
            item in
            
            return CategoriesFilterType(rawValue: String(item)) ?? .All
            
        }
        
        self.selectedDateFilter = DateTimeFilterType(rawValue: LocalPreferences.shared.dateFilter) ?? .All
        
        self.priceFilter = LocalPreferences.shared.priceFilter 
        
    }
    
    
    func updateFilters()
    {
        
        
        self.$selectedCategories.dropFirst(1).sink{
            categories in
            
            LocalPreferences.shared.categoryFilter = categories.map{ item in  return item.rawValue }.joined(separator: ",")
            
        }.store(in: &cancellableSet)
        
        
        self.$selectedDateFilter.dropFirst(1).sink{
            
            date in
            
            LocalPreferences.shared.dateFilter = date.rawValue
            
        }.store(in: &cancellableSet)
        
        
        self.$priceFilter.dropFirst(1).debounce(for: 0.4, scheduler: RunLoop.main).sink{
            price in
            
            LocalPreferences.shared.priceFilter = price
            
        }.store(in: &cancellableSet)
        
    }
    
    func getAllUpcomingEvents()
    {
        
        Task
        {
            
            DispatchQueue.main.async {
                
                self.upcomingEventsIsLoading = true

            }
            
            let results = try await self.eventService.getAllEvents()
            
            if let results = results as? EventResponse
            {
                
                DispatchQueue.main.async {
                    
                    self.upcomingEvents = results.events.map{
                        
                        value in
                        
                        let month = value.datetime_utc?.convertToDate()?.formatDate().split(separator: "-")[0]
                        let day = value.datetime_utc?.convertToDate()?.formatDate().split(separator: "-")[1]
                        let cover = value.performers.first?.image
                        
                        let performers:[Performer] = value.performers.prefix(4).map{
                            
                            performer in
                                
                            return Performer(fullname: performer.name ?? "", image: performer.image ?? "",role: performer.type ?? "")
                        }
                        
                        let event = Event(id: value.id ?? 0, cover: cover ?? "", dayNumber: Int(String(day ?? "0")) ?? 1, month: String(month ?? ""), name: value.title ?? "", location: value.venue.display_location ?? "", datetime: "", performers: performers)
                        
                        return event
                        
                    }
                    
                }
                
                
            }else{
                
                
                
            }
            
            DispatchQueue.main.async {
                
                self.upcomingEventsIsLoading = false
                
            }
        }
        
    }
   
    
    
    func getAllUpcomingEvents(page:Int = 1,itemPerPage:Int = 10)
    {
        
        Task
        {
            
            let url = "\(Consts.URL)events?client_id=\(Consts.clientId)&per_page=\(itemPerPage)&page=\(page)&sort=datetime_utc.asc"
            
            DispatchQueue.main.async {
                
                self.getAllUpcomingEventsState = .loading

            }
            
            let results = try await self.eventService.getAllEvents(url: url)
            
            if let results = results as? EventResponse
            {
                
                DispatchQueue.main.async {
                      
                    
                    self.allUpcomingEvents = results.events.map{
                        
                        value in
                    
                        let dateTime = value.datetime_utc?.convertToDate()?.formatDate(dateFormat: "EEE, MMM d h:mm a")
                        let cover = value.performers.first?.image
                        
                        let performers:[Performer] = value.performers.prefix(4).map{
                            
                            performer in
                                
                            return Performer(fullname: performer.name ?? "", image: performer.image ?? "",role: performer.type ?? "")
                        }
                        
                        let event = Event(id: value.id ?? 0, cover: cover ?? "", dayNumber: 1, month: "", name: value.title ?? "", location: value.venue.display_location ?? "", datetime: dateTime ?? "", performers: performers)
                        
                        return event
                        
                    }
                  
                    
                    
                    self.getAllUpcomingEventsState = self.allUpcomingEvents.isEmpty ? .emptyList : .success
                    
                }
                
            }else{
                
                DispatchQueue.main.async {
                    
                    self.getAllUpcomingEventsState = .failure
                    
                }
                
            }
            
            
            
        }
        
    }
        
    
    func getAllNearbyEvents()
    {
        
        
        DispatchQueue.main.async {
            
            self.nearbyEventsIsLoading = true

        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3))
        {
            
            //self.nearByEvents = MockData.events
            self.nearbyEventsIsLoading = false
            
        }
        
    }
    
    func getEventById(eventId:String)
    {
        
        Task
        {
            
            DispatchQueue.main.async {
            
                self.getEventByIdIsLoading = true
                
            }
            
            let result = try await self.eventService.getEventById(url: "\(Consts.URL)events/\(eventId)?client_id=\(Consts.clientId)")
            
            if let result = result as? EventBodyResponse
            {
                
                let cover = result.performers.first?.image ?? ""
                let date = result.datetime_utc?.convertToDate()?.formatDate(dateFormat: "dd MMMM, yyyy") ?? ""
                let dayTime = result.datetime_utc?.convertToDate()?.formatDate(dateFormat: "EEEE, h:mm a") ?? ""
                
                let performers:[Performer] = result.performers.prefix(4).map{
                    
                    performer in
                        
                    return Performer(fullname: performer.name ?? "", image: performer.image ?? "",role: performer.type ?? "")
                }
                
                let eventDetail:EventDetail = EventDetail(cover: cover, name: result.title ?? "", date: date, dayTime: dayTime, location: "\(result.venue.address ?? ""), \(result.venue.city ?? ""), \(result.venue.country ?? "")", placeName: result.venue.name ?? "",performers: performers)
                
                DispatchQueue.main.async {
                    
                    self.eventDetail = eventDetail
                    
                }
                
                
            }else{
                
                
                
            }
            
            DispatchQueue.main.async {
            
                self.getEventByIdIsLoading = false
                
            }
        }
        
        
    }
    
    func filterEvent()
    {
        
        
        
    }
    
    
    
    
}
