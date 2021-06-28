//
//  DevSupportViewController.swift
//  CustomerProgram
//
//  Created by Sergey Pimenov on 26/07/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class DevSupportViewController: UITableViewController {
    typealias Section = DevSupportState.Section
    typealias CellState = DevSupportState.Section.Item

    // MARK: - Private Reactive

    fileprivate var onScreenDisposeBag = DisposeBag()
    fileprivate lazy var dataSource: RxTableViewSectionedReloadDataSource<Section> = {
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { [unowned self] (_, tableView, indexPath, cellState) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "UITableViewCell",
                    for: indexPath
                )

                switch cellState {
                case let .user(item):
                    switch item {
                    case .logout:
                        cell.textLabel!.text = "Logout"
                    }
                }

                return cell
            },
            titleForHeaderInSection: { (dataSource, section) -> String? in
                let section = dataSource[section]

                switch section.sectionName {
                case .user:
                    return "User"
                }
            }
        )

        return dataSource
    }()

    let viewModel: DevSupportViewModel

    init(viewModel: DevSupportViewModel) {
        self.viewModel = viewModel

        super.init(style: .plain)

        self.navigationItem.title = "Dev Support"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: nil,
            action: nil
        )
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView()
        self.tableView.tableHeaderView = UIView()

        self.view.backgroundColor = .white

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")

        self.setupActions()

        self.tableView.dataSource = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.onScreenDisposeBag = DisposeBag()

        self.viewModel.state
            .map { $0.sections }
            .distinctUntilChanged()
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.onScreenDisposeBag)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.onScreenDisposeBag = DisposeBag()
    }

    private func setupActions() {
        self.tableView.rx.itemSelected
            .do(
                onNext: { [weak self] indexPath in
                    self?.tableView.deselectRow(at: indexPath, animated: true)
            },
                afterNext: { [weak self] (_) in
                    self?.dismiss(animated: true)
            })
            .map {[unowned self] in self.viewModel.state.value.sections[$0.section].items[$0.row] }
            .bind(to: self.viewModel.rx.selected)
            .disposed(by: self.rx.disposeBag)

        self.navigationItem.leftBarButtonItem!.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: self.rx.disposeBag)
    }
}
