<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://www.ascc.net/xml/schematron">
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <sch:pattern name="Attributes">
        <sch:rule context="tei:l">
            <sch:assert test="@xml:id">The element l must have an xml:id</sch:assert>
            <sch:assert test="@n">The element l must have an attribute 'n'</sch:assert>
        </sch:rule>
        <sch:rule context="tei:note">
            <sch:assert test="@type='missing' or @type='addition' or @type='editorial' or @type='alternative' or @type='transposed'">Incorrect or missing @type attribute</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern name="Structure">
        <sch:rule context="tei:note/tei:seg">
            <sch:assert test="@type = 'wit' or @type='text' or @type='comment'">Missing or false attribute in element seg</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>