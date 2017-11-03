import codecs
import lxml.etree as ET

# Transformatio Scenario: isolate_witness.xsl - order_witness.xsl - strip_space.xsl - transform_isolated_witness.xsl
# codecs.open("../TEI/Herz_Synoptische_Transkription.xml", mode='r', encoding'utf-8')
dom1 = ET.parse("../TEI/Herz_Synoptische_Transkription.xml")


xslt1 = ET.parse("isolate_witness.xsl")
transform1 = ET.XSLT(xslt1)
dom2 = transform1(dom1)

tree = ET.ElementTree(dom2)
