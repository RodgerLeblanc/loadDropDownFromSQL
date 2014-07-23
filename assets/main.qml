/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.2
import bb.data 1.0

Page {
    Container {
        DropDown {
            id: dropdown
        }
        ListView {
            id: myListView
            dataModel: dataModel
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    StandardListItem {
                        title: ListItemData.categoryfield
                    }
                } // end of ListItemComponent
            ]
        } // end of ListView        
    }
    
    attachedObjects: [
        GroupDataModel {
            id: dataModel
        },
        DataSource {
            id: dataSource
            
            // Load the data from an SQL database, based on a specific query
            source: "asset:///pinguin.db"
            query: "select categoryfield from items group by categoryfield"
            
            onDataLoaded: {
                // After the data is loaded, insert it into the data model
                // This will populate the ListView. You don't want to show
                // categoryfield in ListView, I just wanted to show the difference
                // between populating a ListView and a DropDown
                dataModel.insertList(data);


				// Now, this will populate the DropDown by iterating through every
				// data from the query and adding it one by one to the DropDown
				// using the optionFactory Component Definition to add dynamically
				// new Options to the DropDown
                for (var i = 0; i < data.length; ++i)
                {                    
                    // Create new Option
                    var newOption = optionFactory.createObject()
                    
                    // Set the Option text to categoryfield
                    newOption.text = data[i].categoryfield
                    
                    // Add the Option to DropDown
                    dropdown.add(newOption);                        
                }
            }
        },
        ComponentDefinition {
            id: optionFactory
            Option {}
        }
// end of DataSource
    ]
    
    onCreationCompleted: {
        // After the root Page is created, direct the data source to start
        // loading data
        dataSource.load();
    }
} // end of Page