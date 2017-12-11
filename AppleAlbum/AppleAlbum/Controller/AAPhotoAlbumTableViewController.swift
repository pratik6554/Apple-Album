//
//  AAPhotoAlbumTableViewController.swift
//  AppleAlbum
//
//  Created by Pratik Gandhi on 11/12/17.
//  Copyright © 2017 Pratik Gandhi. All rights reserved.
//

import UIKit

class AAPhotoAlbumTableViewController: UITableViewController {

  var albumList: [AAAlbum] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 96.0
    tableView.registerNib(cellIdentifier: AACellIdentifierType.AlbumTableCell)
    refreshAlbumList()
  }

  func refreshAlbumList() {

    AAWebServiceManager.fetchAlbumList { [weak self] (response) in
      guard let weakSelf = self else { return }

      if response.isFailure {
        print("Error == \(String(describing: response.error))")
      } else {
        if let value = response.value {
          weakSelf.albumList = value
          DispatchQueue.main.async {
            weakSelf.tableView.reloadData()
          }
        }
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return albumList.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    //TODO: remove force case use dummy cell if cell not found
    let albumCell = tableView.dequeueReusableCell(withIdentifier: AACellIdentifierType.AlbumTableCell.rawValue, for: indexPath) as! AAAlbumTableCell
    let selectedRow = indexPath.row
    if albumList.count > selectedRow {
      albumCell.configure(album: albumList[selectedRow])
    }
    return albumCell
  }

  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */

  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */

  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

   }
   */

  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */

}
