<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document Preview and Search</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.0.0/pdf.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.0.0/pdf.worker.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mammoth/1.4.2/mammoth.browser.min.js"></script>
    <style>
    .input-btn {
    border: 1px solid #005F87;
    padding: 8px;
    cursor: pointer;
    background-color: #005F87;
    color: white;
    white-space: nowrap;
    font-size: 18px;
    font-weight: bold;
    min-width: 100px;
} 
    .polarion-dle-document-paper {
  margin: 0 auto;
  width: 754px;
  margin-top: 25px;
  margin-bottom: 25px;
  padding: 20px;
  padding-left: 40px;
  padding-right: 40px;
  border: 1px solid #CCCCCC;
  border-right: 2px solid #CCCCCC;
  border-bottom: 2px solid #CCCCCC;
}


        .polarion-dle-document h6, .polarion-dle-document h5, .polarion-dle-document h4, .polarion-dle-document h3, .polarion-dle-document h2, .polarion-dle-document h1 {
            color: #004D73;
            font-weight: bold;
            line-height: 1.2;
            font-family: "Segoe UI", "Selawik", "Open Sans", Arial, sans-serif;
            margin: 0.83em 0 0.41em;
        }
        
        
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f9;
            margin: 0;
            padding: 20px;
        }
        .container {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .panel {
            padding: 20px;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .panel h2 {
            margin-top: 0;
            font-size: 1.5em;
            color: #333;
        }
        .form-control {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 40%; 
            box-sizing: border-box;
            margin-bottom: 15px;
        }
        .form-control1 {
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ddd;
    border-radius: 4px;
    width: 100%;
    box-sizing: border-box;
    margin-bottom: 15px;
}
        
        
        .form-control:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(38, 143, 255, 0.25);
        }
        .preview-content {
            margin-top: 20px;
            border-top: 1px solid #ddd;
            padding-top: 20px;
            height: 500px;
            overflow: hidden;
        }
        iframe {
            width: 100%;
            height: 100%;
            border: none;
        }
        .query-list {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        .query-list p {
            margin: 5px 0;
            padding: 10px;
            background-color: #fafafa;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .query-list p:hover {
            background-color: #e9ecef;
        }
        button {
            background-color: #005F87;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #0056b3;
        }
        .file-upload {
            margin-top: 15px;
        }
    .pullRight
    {
  background-color: rgb(207 250 254) !important;
    }  
.chatMessage
{
width:100%;


}

.spinner {
  border: 4px solid rgba(0,0,0,0.1);
  border-left: 4px solid #3498db;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
    </style>
     <div id="content" style="display:none"></div>
    <script>
    const jsonObject = {
    		  "Molex_MST_Requirements": [
    		    {
    		      "H1": "Introduction",
    		      "description": ""
    		    },
    		    {
    		      "H2": "1 Molex Requirements",
    		      "subsections": [
    		        {
    		          "H3": "1.2 Connector",
    		          "subsections": [
    		            {
    		              "H4": "1.2.1 Terminal mechanical",
    		              "requirements": [
    		                {
    		                  "title": "Adequate Normal Force for Plating and Contact Beam Formation",
    		                  "description": ""
    		                },
    		                {
    		                  "title": "Overstress Protection for Receptacle Contacts",
    		                  "description": ""
    		                },
    		                {
    		                  "title": "Compliance with Industry Standards for Mating Force",
    		                  "description": ""
    		                },
    		                {
    		                  "title": "Strong Wire Retention in Conductor and Insulation Crimp",
    		                  "description": ""
    		                },
    		                {
    		                  "title": "Support for Automated Crimping Processes",
    		                  "description": ""
    		                },
    		                {
    		                  "title": "Handling Capabilities Including Resistance to Bending, Snagging, and Crushing",
    		                  "description": ""
    		                }
    		              ]
    		            },
    		            {
    		              "H4": "1.2.2 Connector Mechanical",
    		              "requirements": [
    		                {
    		                  "title": "Mating and Unmating Force Targets",
    		                  "description": ""
    		                },
    		                {
    		                  "title": "Robustness Against Mismating",
    		                  "description": ""
    		                },
    		                {
    		                  "title": "Full Contact Engagement for Reliable Performance",
    		                  "description": ""
    		                },
    		                {
    		                  "title": "Lock Mechanism Unmating Force Targets",
    		                  "description": ""
    		                },
    		                {
    		                  "title": "Lock Strength to Withstand Handling Stress",
    		                  "description": ""
    		                },
    		                {
    		                  "title": "Adequate Polarization Features to Prevent Incorrect Orientation",
    		                  "description": ""
    		                }
    		              ]
    		            },
    		            {
    		              "H4": "1.2.3 Packaging",
    		              "requirements": [
    		                {
    		                  "title": "Protection During Shipping and Handling, Safety, and Sustainability Standards",
    		                  "description": ""
    		                }
    		              ],
    		              "subsections": [
    		                {
    		                  "H5": "1.2.3.1 PCB",
    		                  "requirements": [
    		                    {
    		                      "title": "Heating Requirements for Safe Operation",
    		                      "description": ""
    		                    },
    		                    {
    		                      "title": "Compatibility with Connector Mating Requirements",
    		                      "description": ""
    		                    }
    		                  ]
    		                },
    		                {
    		                  "H5": "1.2.3.2 Sensor",
    		                  "requirements": [
    		                    {
    		                      "title": "Torque Resistance for Sensor Bushing",
    		                      "description": ""
    		                    },
    		                    {
    		                      "title": "Compliance with Design Standard ES-34735-011 for Press-Fit Bushing",
    		                      "description": ""
    		                    },
    		                    {
    		                      "title": "Compliance with Design Standard ES-34735-001 for Safety and Performance",
    		                      "description": ""
    		                    },
    		                    {
    		                      "title": "Molding Product Design Requirements as per ES-34735-017",
    		                      "description": ""
    		                    }
    		                  ]
    		                }
    		              ]
    		            }
    		          ]
    		        }
    		      ]
    		    }
    		  ]
    		};
    
    
    

    function convertToText(obj, indentLevel = 0) {
    	  let text = '';
    	  const indent = ' '.repeat(indentLevel * 2);

    	  for (const key in obj) {
    	    if (Array.isArray(obj[key])) {
    	      // If the value is an array, recurse into each item
    	      obj[key].forEach(subObj => {
    	        text += convertToText(subObj, indentLevel);
    	      });
    	    } else if (typeof obj[key] === 'object') {
    	      // If the value is an object, recurse into the object
    	      text += convertToText(obj[key], indentLevel + 1);
    	    } else {
    	      if (key.startsWith('H')) {
    	        // Check if key starts with 'H' and then extract the number
    	        const headingLevel = parseInt(key.substring(1), 10);
    	        text += `${indent}${'#'.repeat(headingLevel)} ${obj[key]}\n`;
    	      } else if (key === 'title') {
    	        // Format the title as a requirement
    	        text += `${indent}**Requirement:** ${obj[key]}\n`;
    	      } else if (key === 'description') {
    	        // Format the description
    	       text += `${indent}*Description:* ${obj[key]}\n\n`;
    	      }
    	    }
    	  }

    	  return text;
    	}


    		const resultText = convertToText(jsonObject);
    		console.log("RTesult Text : " + resultText);
    		function convertToHTML(obj, indentLevel = 0) {
    			  let html = '';

    			  for (const key in obj) {
    			    if (Array.isArray(obj[key])) {
    			      obj[key].forEach(subObj => {
    			        html += convertToHTML(subObj, indentLevel);
    			      });
    			    } else if (typeof obj[key] === 'object') {
    			      html += convertToHTML(obj[key], indentLevel + 1);
    			    } else {
    			      if (key.startsWith('H')) {
    			        const headingLevel = parseInt(key.substring(1), 10);
    			        html += `<h${headingLevel}>${obj[key]}</h${headingLevel}>\n`;
    			      } else if (key === 'title') {
    			    	  html += `<div id="requirement">\n`;
    			          html += ` ${obj[key]}\n`;
    			          html += `</div>\n`; 
    			      } else if (key === 'description') {
    			    	 //   html += `Description: ${obj[key]}\n`;
    			    	 //   html += `</div>\n`; 
    			      }
    			    
    			    }
    			  }

    			  return html;
    			}

    			const resultHTML = convertToHTML(jsonObject);
    			
    	//const resultHTML ="<h1>h1 Data</h1><h2>h2 data</h2><h3 >h3 data</h3><p>This document describes couple of requirements related to the configuration (administration) portal.</p><h3>h3 dta</h3><p >Specifications:</p><ul> <li>dta<li></ul><p>Testing:</p><ul ><li></li></ul><h2 >h2 dtaa</h2><h3>h3 data</h3><p>text data</p>"
    			const tempDiv = document.createElement('div');
    			tempDiv.innerHTML = resultHTML;
    			console.log(tempDiv.innerHTML);
    	//	console.log(resultText);

    
    
    var chatArray=[];
        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);
            const projectId = urlParams.get('projectId');

            if (projectId === null) {
                alert("Set the project ID in the URL parameter");
            } else {
                fetch(`documentContentAppend?action=getDocumentList&projectId=${projectId}`, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(response => response.json())
                .then(data => {
                    const $selectElement = document.getElementById("docDropdown");
                    $selectElement.innerHTML = "<option value=''>Select a Document</option>";

                    Object.entries(data).forEach(([id, name]) => {
                        const option = document.createElement('option');
                        option.value = id;
                        option.textContent = name;
                        $selectElement.appendChild(option);
                    });
                })
                .catch(error => {
                    console.error("Error fetching document list:", error);
                });
            }
        });

        function loadDocument() {
            const select = document.getElementById("docDropdown");
            const selectedDocId = select.value;
            const urlParams = new URLSearchParams(window.location.search);
            const projectId = urlParams.get('projectId');
            if (!selectedDocId) {
                alert("Please select a document.");
                return;
            }

            fetch(`documentContentAppend?action=getDocumentContent&projectId=${projectId}&docId=${encodeURIComponent(selectedDocId)}`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data != null) {
                    const previewDiv = document.getElementById("preview");
                    const url = new URL(window.location.href);
                    const hostname = url.protocol + "//" + url.hostname;
                   
                    let dynamicUrl;
                    if (data.relativePath.startsWith("_default")) {
                        dynamicUrl = `/polarion/#/project/${encodeURIComponent(projectId)}/wiki/${encodeURIComponent(selectedDocId)}`;
                    } else {
                        dynamicUrl = `/polarion/#/project/${encodeURIComponent(projectId)}/wiki/${encodeURIComponent(data.relativePath)}`;
                    }
                 //   console.log(data.content.content)
                   //  document.getElementById('content').innerHTML = data.content.content;
                    
                    const fullUrl = hostname + dynamicUrl;
                    
                    previewDiv.src = fullUrl;
                 
                  


                    
                    
                    const elementsToHide = document.querySelectorAll('body *:not(.polarion-dle-document):not(.polarion-dle-document-paper)');
                 
                    elementsToHide.forEach(element => {
                       // alert(`ID: ${element.id}, Tag: ${element.tagName}, Classes: ${element.className}`);
                    });

                   
                }
                
            })
            
            
            .catch(error => {
                console.error("Error fetching document content:", error);
            });
        }

        
        function searchQuery() {
            // Get the query from the input field
            const query = document.getElementById('searchBox').value;
            
      
            
            if (!query) {
                alert('Please enter a query.');
                return;
            }
            
            chatArray.push({"type":"request","text":query})
            
            // Example API URL (replace with your actual API endpoint)
            const apiUrl = 'https://jsonplaceholder.typicode.com/posts';
            
            // Fetch request
            fetch(apiUrl, {
                method: 'POST', 
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    query: query
                })
            })
            .then(response => response.json())
            .then(data => {
            	var responseQuery = "this is response from api" ;
            	   chatArray.push({"type":"response","text":resultHTML})
            	   document.getElementById('searchBox').value="";
            	   prepareChatDiv()
            })
            .catch(error => {
                // Display error if fetch fails
                const errorMessage = document.createElement('div');
                errorMessage.className = 'message response-message';
                errorMessage.textContent = 'Error: ' + error.message;
            
            });
        }
        
        function prepareChatDiv()
        {
        	const queryListDiv = document.getElementById('queryList');
        	queryListDiv.innerHTML="";
        	var htmldata = "";
        	for(var i=0;i<chatArray.length;i++ )
        		{
        		var string=chatArray[i].text;
        	
        		htmldata += "<div>" ;
        	if(chatArray[i].type == "response")
        	{
        		htmldata += "<span class='chatMessage'><p>"+string+"</p></span>"
        		
        		   if (i === chatArray.length - 1) {
        			   htmldata += `<img src='/polarion/ria/images/documents/import-changes.png' 
        				   onclick='saveQuery()' 
        				   style="cursor: pointer; width: 18px; height: 18px;" 
        				   title="Insert into document" />`;

                   }
        	}
        	else
        		{
        		htmldata += "<span class='chatMessage pullRight'><p class='pullRight'>"+string+"</p></span>"
        		
        		}
        	
        		htmldata += "</div>" ;
        		
        		}
        	queryListDiv.innerHTML = htmldata;
        }
        
       
        
        function saveQuery() {
       //    alert(query)
       //     if (query.trim() === "") {
        //        alert("Please enter a query before saving.");
       //         return;
         //   }
            const queryListDiv = document.getElementById("queryList");
            const urlParams = new URLSearchParams(window.location.search);
            const projectId = urlParams.get('projectId');
            const selectedDocId = document.getElementById("docDropdown").value;

            if (!projectId || !selectedDocId) {
                alert("Project ID or Document ID is missing.");
                return;
            }
            document.getElementById("loader").style.display = 'block';
            const fetchUrl = `documentContentAppend?action=saveQuery&projectId=${projectId}&docId=${selectedDocId}`;

            fetch(fetchUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                	 query: resultHTML
                })
              
            })
             
                
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                console.log('Query saved successfully:', data);
               
                setTimeout(() => {
                    document.getElementById("loader").style.display = 'none';
                    
                    // Show the overlay and popup
                    document.getElementById("overlay").style.display = 'block';
                    document.getElementById("successPopup").style.display = 'block';
                }, 3000);
                // Show the success popup
               
              //  if (query) {
                  /*  const queryParagraph = document.createElement('p');
                    queryParagraph.textContent = query;
                    queryParagraph.onclick = function() {
                        document.getElementById("searchBox").value = query; 
                    };
                    queryListDiv.insertBefore(queryParagraph, queryListDiv.firstChild); 
                    document.getElementById("searchBox").value = ""; */
             //   } else {
                //    alert("Please enter a query.");
              //  }
            })
            .catch(error => {
                console.error('Error saving query:', error);
            });
        }

        function closePopup() {
            document.getElementById("successPopup").style.display = 'none';
            document.getElementById("overlay").style.display = 'none';
            const previewDiv = document.getElementById("preview");
            const iframeSrc = previewDiv.src;
            previewDiv.src = iframeSrc;
        }
        
        
        /* function triggerFileInput() {
            const fileInput = document.getElementById('fileInput');
            if (fileInput) {
                fileInput.click();
                fileInput.addEventListener('change', function() {
                    const file = this.files[0];
                    if (file) {
                        const fileType = file.type;
                        if (fileType === 'application/pdf' || fileType === 'application/vnd.openxmlformats-officedocument.wordprocessingml.document') {
                            uploadFile(file);
                        } else {
                            alert('Unsupported file type.');
                        }
                    }
                });
            } else {
                console.error('File input element not found.');
            }
        } */

        
        function uploadFile(file) {
        	const fileInput = document.getElementById('fileInput');
        	console.log("fileInput",fileInput);
            const urlParams = new URLSearchParams(window.location.search);
            const projectId = urlParams.get('projectId');
            const selectedDocId = document.getElementById("docDropdown").value;

            if (!projectId || !selectedDocId) {
                alert("Project ID or Document ID is missing.");
                return;
            }

            const formData = new FormData();
            formData.append('file', file);
            formData.append('projectId', projectId);
            formData.append('docId', selectedDocId);
            
            const fetchUrl = `documentContentAppend?action=uploadDocument&projectId=${encodeURIComponent(projectId)}&docId=${encodeURIComponent(selectedDocId)}`;
            
            fetch(fetchUrl, {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                console.log('File uploaded successfully:', data);
            })
            .catch(error => {
                console.error('Error uploading file:', error);
                alert('Error uploading file');
            });
        }
    </script>
</head>
<body>

    <div class="container">
        <!-- Panel 1: Document Dropdown and Preview -->
        <div class="panel" style="width:60%">
            <h2>Document Preview</h2>
            <select id="docDropdown" class="form-control1" onchange="loadDocument()">
                <!-- Options will be added here dynamically by JavaScript -->
            </select>
            <div id="previewContent" class="preview-content">
                <iframe id="preview" class="polarion-dle-RichTextArea"></iframe>
            </div>
        </div>

        <!-- Panel 2: Search and Query List -->
       
       <div class="panel" style="width:33%;position:fixed;left:780px;">
    <h2>Search</h2>
    <div style="height: 525px; overflow: auto;">
        <div id="queryList" class="query-list" style="max-height: 100%; overflow-y: auto;">
        
        </div>
       
    </div>
    
    <div class="file-upload" >
          <input type="text" id="searchBox" class="form-control" placeholder="Enter your query here" />
            <button class="input-btn" onclick="searchQuery()">Search</button>
            <button class="input-btn" onclick="uploadFile()">Upload</button>
          <input type="file" id="fileInput" class="form-control" accept=".pdf,.docx" style="display: none;" />
    </div>
             
</div>
       
        
        
        
    </div>

<div id="loader" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);">
    <img src="\polarion\ria\images\progress.gif" alt="Loading..." />
</div>


<div id="overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 10;"></div>


<div id="successPopup" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #fff; border: 1px solid #ddd; padding: 20px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); z-index: 11;">
    <p>Query Response Appended successfully!</p>
  <div style="text-align: center;"> <button class="input-btn" onclick="closePopup()">Close</button></div>
</div>

    
</body>
</html>
