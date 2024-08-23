package com.polarion.documentcontentappend;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.polarion.alm.projects.model.IFolder;
import com.polarion.alm.tracker.ITrackerService;
import com.polarion.alm.tracker.model.IModule;
import com.polarion.alm.tracker.model.ITrackerProject;
import com.polarion.alm.tracker.model.IWorkItem;
import com.polarion.core.util.types.Text;
import com.polarion.platform.ITransactionService;
import com.polarion.platform.core.PlatformContext;
import com.polarion.platform.persistence.UnresolvableObjectException;
import com.polarion.subterra.base.location.ILocation;
import com.polarion.subterra.base.location.Location;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DocumentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        // Handle AJAX request for document list
        if ("getDocumentList".equals(action)) {
            String projectId = req.getParameter("projectId");
            if (projectId == null || projectId.trim().isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Project ID is required.");
                return;
            }

            ITrackerService trackerService = (ITrackerService) PlatformContext.getPlatform().lookupService(ITrackerService.class);
            Map<String, String> documentList = new HashMap<>();
            
            try {
                ITrackerProject trackerProject = trackerService.getTrackerProject(projectId);
                List<IFolder> folders = trackerService.getFolderManager().getFolders(projectId);

                for (IFolder folder : folders) {
                    String folderName = folder.getName();
                    ILocation location = Location.getLocation(folderName);
                    List<IModule> modules = trackerService.getModuleManager().getModules(trackerProject, location);

                    for (IModule module : modules) {
                        try {
                        	//System.out.println( module.getRelativePath());
                        	
                            documentList.put(module.getId(), module.getModuleName());
                        } catch (UnresolvableObjectException e) {
                            // Handle exception
                        } catch (Exception e) {
                            e.printStackTrace();
                            continue;
                        }
                    }
                }

                // Convert documentList to JSON and write to response
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                Gson gson = new Gson();
                String jsonResponse = gson.toJson(documentList);
                resp.getWriter().write(jsonResponse);

            } catch (Exception e) {
                e.printStackTrace();
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the request.");
            }
        }
        else if ("getDocumentContent".equals(action)) {
           
            String projectId = req.getParameter("projectId");
            String documentId = req.getParameter("docId");
        

            ITrackerService trackerService = (ITrackerService) PlatformContext.getPlatform().lookupService(ITrackerService.class);
            Map<String, Object> responseMap = new HashMap<>();

            try {
                ITrackerProject project = trackerService.getTrackerProject(projectId);
                List<IFolder> folders = trackerService.getFolderManager().getFolders(projectId);

                for (IFolder folder : folders) {
                    ILocation location = Location.getLocation(folder.getName());
                    List<IModule> modules = trackerService.getModuleManager().getModules(project, location);

                    for (IModule module : modules) {
                        if (module.getId().equals(documentId)) {
                            // Assuming you want to return the content as a string
                            Text content = module.getHomePageContent().convertToHTML();
                      //   System.out.println("module.getHomePageContent() "+module.getHomePageContent().convertToHTML());
                            String relativePath = module.getRelativePath();
                            responseMap.put("relativePath", relativePath);
                           
                     
                         //   System.out.println("content "+content);
                            // Adjust based on actual content retrieval
                           
                            responseMap.put("content", content);
                            break;
                        }
                    }
                }

                // Convert responseMap to JSON and write to response
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                Gson gson = new Gson();
                String jsonResponse = gson.toJson(responseMap);
                resp.getWriter().write(jsonResponse);

            } catch (Exception e) {
                e.printStackTrace();
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the request.");
            }
        }

        else if ("saveQuery".equals(action)) {
            String projectId = req.getParameter("projectId");
            String documentId = req.getParameter("docId");
            String query = req.getParameter("query"); // Extract the query parameter

            ITrackerService trackerService = (ITrackerService) PlatformContext.getPlatform().lookupService(ITrackerService.class);
            Map<String, Object> responseMap = new HashMap<>();

            try {
                ITrackerProject project = trackerService.getTrackerProject(projectId);
                List<IFolder> folders = trackerService.getFolderManager().getFolders(projectId);

                for (IFolder folder : folders) {
                    ILocation location = Location.getLocation(folder.getName());
                    List<IModule> modules = trackerService.getModuleManager().getModules(project, location);

                    for (IModule module : modules) {
                        if (module.getId().equals(documentId)) {
                            // Assuming you want to append the query to the existing content
                            Text existingContent = module.getHomePageContent();
                            String updatedContent = existingContent.toString() + "<p>" + query + "</p>";
                            Text updatedTextContent = Text.html(updatedContent);

                            // Begin transaction
                            ITransactionService transactionService = (ITransactionService) PlatformContext.getPlatform().lookupService(ITransactionService.class);
                            transactionService.beginTx();

                            try {
                                module.setHomePageContent(updatedTextContent);
                                module.save();
                                transactionService.endTx(false); // Commit the transaction
                            } catch (Exception e) {
                                transactionService.endTx(true); // Rollback the transaction in case of error
                                throw e; // Re-throw the exception to handle it in the catch block
                            }

                            // Prepare response
                            responseMap.put("status", "success");
                            responseMap.put("query", query);
                            break;
                        }
                    }
                }

                // Convert responseMap to JSON and write to response
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                Gson gson = new Gson();
                String jsonResponse = gson.toJson(responseMap);
                resp.getWriter().write(jsonResponse);

            } catch (Exception e) {
                e.printStackTrace();
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the request.");
            }
        }

        
        else {
            // For other actions, forward to the JSP or handle accordingly
            getServletContext().getRequestDispatcher("/document.jsp").forward(req, resp);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    	    throws ServletException, IOException {
    	    String action = request.getParameter("action");

    	    if ("saveQuery".equals(action)) {
    	        JsonObject requestBody = new Gson().fromJson(new InputStreamReader(request.getInputStream()), JsonObject.class);
    	        String queryHtml = requestBody.get("query").getAsString(); // Extract HTML content

    	        String projectId = request.getParameter("projectId");
    	        String documentId = request.getParameter("docId");

    	        Map<String, Object> responseMap = new HashMap<>();
    	        StringBuilder sb = new StringBuilder();
    	        ITrackerService trackerService = (ITrackerService) PlatformContext.getPlatform().lookupService(ITrackerService.class);

    	        try {
    	            ITrackerProject project = trackerService.getTrackerProject(projectId);
    	            List<IFolder> folders = trackerService.getFolderManager().getFolders(projectId);
    	            boolean documentUpdated = false;

    	            for (IFolder folder : folders) {
    	                ILocation location = Location.getLocation(folder.getName());
    	                List<IModule> modules = trackerService.getModuleManager().getModules(project, location);

    	                for (IModule module : modules) {
    	                    if (module.getId().equals(documentId)) {
    	                        String existingContent = module.getHomePageContent().toString();
    	                       System.out.println("module.getHomePageContent() "+module.getHomePageContent());
    	                        sb.append(existingContent);
    	                        sb.append(queryHtml);
    	                        Text updatedTextContent = Text.html(sb.toString());

    	                        ITransactionService transactionService = (ITransactionService) PlatformContext.getPlatform().lookupService(ITransactionService.class);

    	                        try {
    	                            transactionService.beginTx();

    	                            // Define regex patterns for headings and requirements
    	                            Pattern headingPattern = Pattern.compile("<h(\\d)>(.*?)</h\\1>");
    	                            Pattern requirementPattern = Pattern.compile(
    	                            	    "<div\\s+id=\"requirement\">\\s*(.*?)\\s*</div>",
    	                            	    Pattern.CASE_INSENSITIVE | Pattern.DOTALL
    	                            	);
    	                       System.out.println("queryHtml "+queryHtml);
    	                            Matcher headingMatcher = headingPattern.matcher(queryHtml);
    	                            Matcher requirementMatcher = requirementPattern.matcher(queryHtml);
    	                            IWorkItem headingItem;
    	                            // Process headings
    	                            while (headingMatcher.find()) {
    	                                int headingLevel = Integer.parseInt(headingMatcher.group(1));
    	                                String title = headingMatcher.group(2).trim();
    	                                
    	                                // Create heading work item
    	                               headingItem  = module.createWorkItem("heading");
    	                               headingItem.setTitle(title);
    	                               
    	                              headingItem.save();
    	                            }

    	                            System.out.println("requirementMatcher.find() "+requirementMatcher.find());
    	                            // Process requirements
    	                            while (requirementMatcher.find()) {
    	                                String title = requirementMatcher.group(1).trim();
    	                             //   String description = requirementMatcher.group(2).trim();
    	                              //  System.out.println("description "+description);
    	                                // Create requirement work item
    	                               headingItem = module.createWorkItem("systemrequirement");
    	                               headingItem.setTitle(title);
    	                              //  headingItem.setDescription(Text.html(sb.toString()));
    	                               headingItem.save();
    	                            }

    	                            // Update module content
    	                      //     module.setHomePageContent(updatedTextContent);
    	                            module.save();
    	                            transactionService.endTx(false); // Commit the transaction
    	                            documentUpdated = true;
    	                        } catch (Exception e) {
    	                         //   transactionService.endTx(true); // Rollback the transaction in case of error
    	                            e.printStackTrace();
    	                        }

    	                        break;
    	                    }
    	                }

    	                if (documentUpdated) {
    	                    break;
    	                }
    	            }

    	            // Prepare and send response
    	            responseMap.put("status", documentUpdated ? "success" : "failure");
    	            response.setContentType("application/json");
    	            response.setCharacterEncoding("UTF-8");
    	            String jsonResponse = new Gson().toJson(responseMap);
    	            response.getWriter().write(jsonResponse);

    	        } catch (Exception e) {
    	            e.printStackTrace();
    	            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the request.");
    	        }
    	    } else {
    	        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
    	    }
    	}


    
    private static void createWorkItem(String type, String title, IModule module) {
     
System.out.println("title "+title);
        try {
        	   ITransactionService transactionService = (ITransactionService) PlatformContext.getPlatform().lookupService(ITransactionService.class);
            transactionService.beginTx();
            module.createWorkItem(type).setTitle(title);
           
            module.save();
            System.out.println("module.getId "+module.getAllWorkItems());
            
            transactionService.endTx(false); 
        } catch (Exception e) {
          
            e.printStackTrace();
        }
    }
    
}
