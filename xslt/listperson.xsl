<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
   version="2.0" exclude-result-prefixes="xsl tei xs">
   <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
   
   <xsl:import href="./partials/html_navbar.xsl"/>
   <xsl:import href="./partials/html_head.xsl"/>
   <xsl:import href="partials/html_footer.xsl"/>
   <xsl:import href="partials/osd-container.xsl"/>
   <xsl:import href="partials/tei-facsimile.xsl"/>
   <xsl:template match="/">
      <xsl:variable name="doc_title">
         <xsl:value-of select=".//tei:title[@type='main'][1]/text()"/>
      </xsl:variable>
      <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
      <html>
         <xsl:call-template name="html_head">
            <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
         </xsl:call-template>
         
         <body class="page">
            <div class="hfeed site" id="page">
               <xsl:call-template name="nav_bar"/>
               
               <div class="container-fluid">                        
                  <div class="card">
                     <div class="card-header">
                        <h1><xsl:value-of select="$doc_title"/></h1>
                     </div>
                     <div class="card-body">                                
                        <table class="table table-striped display" id="tocTable" style="width:100%">
                           <thead>
                              <tr>
                                 <th scope="col">Nachname</th>
                                 <th scope="col">erwähnt in</th>
                                 <th scope="col">Anzahl Erwähnungen</th>
                              </tr>
                           </thead>
                           <tbody>
                              <xsl:for-each select=".//tei:person">
                                 
                                 <tr>
                                    <td>
                                       <xsl:value-of select=".//tei:persName/text()"/>
                                    </td>
                                     <td>                                        
                                       <xsl:for-each select=".//tei:event">
                                          <li>
                                             <a>
                                                <xsl:attribute name="href">
                                                   <xsl:value-of select="replace(substring-after(data(.//tei:ptr/@target), ':'), '.xml', '.html')"/>
                                                </xsl:attribute>
                                                <xsl:value-of select="./tei:label/text()"/>
                                             </a>
                                          </li>
                                       </xsl:for-each>
                                    </td>
                                    <td>
                                       <xsl:value-of select="count(.//tei:event)"/>
                                    </td>
                                 </tr>
                              </xsl:for-each>
                           </tbody>
                        </table>
                     </div>
                  </div>                       
               </div>
               <xsl:call-template name="html_footer"/>
               <script>
                  $(document).ready(function () {
                  createDataTable('tocTable')
                  });
               </script>
            </div>
         </body>
      </html>
   </xsl:template>
   
   <xsl:template match="tei:p">
      <p id="{generate-id()}"><xsl:apply-templates/></p>
   </xsl:template>
   <xsl:template match="tei:div">
      <div id="{generate-id()}"><xsl:apply-templates/></div>
   </xsl:template>
   <xsl:template match="tei:lb">
      <br/>
   </xsl:template>
   <xsl:template match="tei:unclear">
      <abbr title="unclear"><xsl:apply-templates/></abbr>
   </xsl:template>
   <xsl:template match="tei:del">
      <del><xsl:apply-templates/></del>
   </xsl:template>    
</xsl:stylesheet>