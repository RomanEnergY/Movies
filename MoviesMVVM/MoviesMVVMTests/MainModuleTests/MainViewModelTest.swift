//
//  MainViewModelTest.swift
//  MoviesMVVMTests
//
//  Created by 1234 on 21.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import XCTest
@testable import MoviesMVVM

class MainViewModelTest: XCTestCase {
    var assemblyBuilder: AssemblyBuilderProtocol?
    var router: RouterProtocol?
    var mainView: MainView?
    
    override func setUpWithError() throws {
        assemblyBuilder = MockAssemblyBuilder()
        router = Router(navigationController: UINavigationController(), assemblyBuilderProtocol: assemblyBuilder)
        router?.initialViewController()
        
        if let router = router,
           let assemblyBuilder = assemblyBuilder,
           let mainView = assemblyBuilder.createModuleMain(router: router) as? MainView {
            self.mainView = mainView
        }
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testMainModuleNotNil() {
        XCTAssertNotNil(assemblyBuilder)
        XCTAssertTrue(assemblyBuilder is MockAssemblyBuilder)
        
        XCTAssertNotNil(router)
        XCTAssertTrue(router is Router)
        
        XCTAssertNotNil(mainView)
        
        let viewModel = mainView?.viewModel
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel is MockMainViewModel)
        
        let movies = viewModel?.movies
        XCTAssertNotNil(movies)
        XCTAssertEqual(movies!.count, 0)
    }
    
    func testViewModelInitialStartData() {
        mainView?.viewModel?.initialStartData()
        let movies = [MockMainViewModelConst.movieStartData]
        
        XCTAssertEqual(mainView!.viewModel!.movies!.count, 1)
        XCTAssertEqual(mainView!.viewModel!.movies!.first?.id, movies.first?.id)
        XCTAssertTrue(mainView?.viewModel?.movies is [MockMainMovie])
    }
    
    func testAddData() {
        mainView?.viewModel?.initialStartData() // add 1 movie
        mainView?.beginBatchFetch() // add 2 movie, total 3 movie
        
        let moviesData = MockMainViewModelConst.moviesData
        
        XCTAssert(mainView!.viewModel!.movies!.contains{ $0.id == moviesData.first!.id })
        XCTAssertEqual(mainView!.viewModel!.movies!.count, 3)
    }
    
    func testShoweDetail() {
        let viewModel = mainView?.viewModel
        viewModel?.initialStartData()
        
        var checkMovie = false
        if let movie = viewModel?.movies!.first {
            checkMovie = true
            viewModel?.showeDetail(movie: movie)
        }
        XCTAssert(checkMovie, "is not nil")
        
        var checkShoweDetail = false
        if let viewModel = mainView?.viewModel as? MockMainViewModel {
            checkShoweDetail = viewModel.checkShoweDetail
        }
        
        XCTAssert(checkShoweDetail, "is not nil")
    }
}
