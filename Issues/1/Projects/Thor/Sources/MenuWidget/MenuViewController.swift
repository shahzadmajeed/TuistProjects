import UIKit

public struct MenuItem {
    
    public init(title: String, handler: @escaping () -> Void) {
        self.title = title
        self.handler = handler
    }
    
    let title: String
    let handler: () -> Void
}

public class MenuViewController: UITableViewController {

    public var menu: [MenuItem] = [] {
        didSet { self.tableView.reloadData() }
    }
    
    public convenience init(_ menu: [MenuItem]) {
        self.init(nibName: nil, bundle: nil)
        defer { self.menu = menu }
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    public override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = menu[indexPath.row].title
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        menu[indexPath.row].handler()
    }
}
