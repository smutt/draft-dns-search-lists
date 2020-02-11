  ---------------------------------------- -------------------
  Network Working Group                    A. McConachie
  Internet-Draft                           ICANN
  Updates: 1536 (if approved)              W. Kumari
  Intended status: Best Current Practice   Google
  Expires: June 3, 2019                    November 30, 2018
  ---------------------------------------- -------------------

DNS Search List Best Current Practices\
[draft-mcconachie-search-list-00]{.filename}

[Abstract](#rfc.abstract) {#rfc.abstract}
=========================

A Domain Name System (DNS) \"search list\" (hereafter, simply \"search
list\") is an ordered list of domain names. When a user enters a name,
the domain names in the search list are used as suffixes to the
user-supplied name, one by one, until a domain name with the desired
associated data is found or the search list is exhausted.\[Ed note: This
definintion is lifted from RFC 1123.\]

Processing search lists was weakly standardized in early Requests For
Comments (RFCs)\[Ed note: need refs here\] and implemented in most
operating systems. However, as the Internet has grown, search list
behavior has diversified. Applications (e.g., web browsers, mail
clients) and DNS resolvers process search lists differently. In
addition, some of these behaviors present security and privacy issues to
end systems, can lead to performance problems for the Internet, and can
cause collisions with names provisioned under delegated top-level
domains.

In this document, we make three proposals regarding when and how to use
DNS search lists.

\[ Ed note (remove): This document is being developed in github:
https://github.com/smutt/draft-dns-search-lists \]

[Status of This Memo](#rfc.status) {#rfc.status}
==================================

This Internet-Draft is submitted in full conformance with the provisions
of BCP 78 and BCP 79.

Internet-Drafts are working documents of the Internet Engineering Task
Force (IETF). Note that other groups may also distribute working
documents as Internet-Drafts. The list of current Internet-Drafts is at
https://datatracker.ietf.org/drafts/current/.

Internet-Drafts are draft documents valid for a maximum of six months
and may be updated, replaced, or obsoleted by other documents at any
time. It is inappropriate to use Internet-Drafts as reference material
or to cite them other than as \"work in progress.\"

This Internet-Draft will expire on June 3, 2019.

[Copyright Notice](#rfc.copyrightnotice) {#rfc.copyrightnotice}
========================================

Copyright (c) 2018 IETF Trust and the persons identified as the document
authors. All rights reserved.

This document is subject to BCP 78 and the IETF Trust\'s Legal
Provisions Relating to IETF Documents
(https://trustee.ietf.org/license-info) in effect on the date of
publication of this document. Please review these documents carefully,
as they describe your rights and restrictions with respect to this
document. Code Components extracted from this document must include
Simplified BSD License text as described in Section 4.e of the Trust
Legal Provisions and are provided without warranty as described in the
Simplified BSD License.

------------------------------------------------------------------------

[Table of Contents](#rfc.toc) {#rfc.toc .np}
=============================

1\. [Introduction](#rfc.section.1)

-   1.1. [Requirements notation](#rfc.section.1.1)

2\. [Proposal](#rfc.section.2)

-   2.1. [Implicit search lists](#rfc.section.2.1)
-   2.2. [Overriding manually configured search lists](#rfc.section.2.2)
-   2.3. [Querying unqualified single-label domain
    names](#rfc.section.2.3)

3\. [Negative Consequences For the Change](#rfc.section.3)

4\. [IANA Considerations](#rfc.section.4)

5\. [Security Considerations](#rfc.section.5)

6\. [Acknowledgements](#rfc.section.6)

7\. [References](#rfc.references)

-   7.1. [Normative References](#rfc.references.1)
-   7.2. [Informative References](#rfc.references.2)

Appendix A. [Changes / Author Notes.](#rfc.appendix.A)

[Authors\' Addresses](#rfc.authors)

[1.](#rfc.section.1) Introduction {#rfc.section.1}
=================================

Many organizations create subdomains under their primary domain(s) to
delegate or distribute management of their namespace, reduce the load on
their authoritative DNS servers, and more easily distinguish a host\'s
organizational and/or geographical affiliations.

As a convenience to users, many operating systems implement search list
processing, a feature that allows a user to enter a partial name in an
application, with the operating system expanding the name through
entries in a search list. For example, if a user has a search list of
\"corp.example.com;berlin.example.com;example.com\" and she types
\"system\" into her browser\'s address box, the operating system would
try \"system.corp.example.com\", \"system.berlin.example.com\",
\"system.example.com\", and perhaps \"system.\" in some order.

Search list processing, including order of operations for search list
processing, was loosely specified in [\[RFC1123\]](#RFC1123){.xref}
(specifically, section 6.1.4.3 (2)), [\[RFC1535\]](#RFC1535){.xref}, and
[\[RFC1536\]](#RFC1536){.xref} and has been implemented in most
operating systems. Processing of search lists received via DHCP and IPv6
Router Advertisements (RA) is standardized in
[\[RFC3397\]](#RFC3397){.xref} and [\[RFC6106\]](#RFC6106){.xref}. As
the Internet has grown, search list behavior has diversified.
Applications (e.g., web browser and mail clients) and DNS resolvers
process search list suffixes differently. Some of these behaviors also
present security and privacy issues to end systems
[\[SAC064\]](#SAC064){.xref} [\[RFC3397\]](#RFC3397){.xref}, and
performance problems both for the end system and the Internet.

[1.1.](#rfc.section.1.1) Requirements notation {#rfc.section.1.1}
==============================================

The key words \"MUST\", \"MUST NOT\", \"REQUIRED\", \"SHALL\", \"SHALL
NOT\", \"SHOULD\", \"SHOULD NOT\", \"RECOMMENDED\", \"MAY\", and
\"OPTIONAL\" in this document are to be interpreted as described in
[\[RFC2119\]](#RFC2119){.xref}.

[2.](#rfc.section.2) Proposal {#rfc.section.2}
=============================

[2.1.](#rfc.section.2.1) Implicit search lists {#rfc.section.2.1}
==============================================

If search lists are required, operators MUST configure the search list
manually, and MUST NOT use implicit search lists.

An implicit search list is a search list derived from some part of a
host\'s Fully Qualified Domain Name (FQDN). The most common implicit
search list is a list with a single entry composed only of the host\'s
immediate parent domain. For example, a host with FQDN a.example.org
might have an implicit search list of example.org.

This behavior updates the advice given in [\[RFC1536\]](#RFC1536){.xref}
section 6.

[2.2.](#rfc.section.2.2) Overriding manually configured search lists {#rfc.section.2.2}
====================================================================

A search list configured manually on a host by an operator SHOULD NOT be
overridden by DHCP or IPv6 Router Advertisements (RA). If no search list
is configured manually on a host a network operator MAY advertise a
search list via DHCP or IPv6 RA.

For a discussion of how hosts should process DNS search lists learned
via DHCP or IPv6 RAs see [\[RFC6106\]](#RFC6106){.xref} section 5.3.1.

[2.3.](#rfc.section.2.3) Querying unqualified single-label domain names {#rfc.section.2.3}
=======================================================================

Unqualified single label domain names MUST NOT be queried directly. When
a user enters a single label name into an application, that name may be
subject to search list processing if a search list is specified, but
must never be queried in the DNS in its original single-label form.

[3.](#rfc.section.3) Negative Consequences For the Change {#rfc.section.3}
=========================================================

There are operators that today rely on a combination of both implicit
search lists, and the automatic propagation of search lists to clients
via DHCP or IPv6 RA. The proposed changes would require operators to
update their procedures.

Changing search list behavior of unqualified multi-label domain names
MAY potentially reduce the utility of these names.

Not all applications currently in use treat these categories of domain
names in the same way. Incompatibilities and operational problems,
specifically in BYOD (Bring Your Own Device) environments, already
exist.

[4.](#rfc.section.4) IANA Considerations {#rfc.section.4}
========================================

None

[5.](#rfc.section.5) [Security Considerations](#security){#security} {#rfc.section.5}
====================================================================

TBD

[6.](#rfc.section.6) Acknowledgements {#rfc.section.6}
=====================================

Thanks to the ICANN Security and Stability Advisory Committee.

[7.](#rfc.references) References {#rfc.references}
================================

[7.1.](#rfc.references.1) Normative References {#rfc.references.1}
==============================================

  ----------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  **\[RFC1034\]**   Mockapetris, P., \"[Domain names - concepts and facilities](https://tools.ietf.org/html/rfc1034)\", STD 13, RFC 1034, DOI 10.17487/RFC1034, November 1987.
  **\[RFC1123\]**   Braden, R., \"[Requirements for Internet Hosts - Application and Support](https://tools.ietf.org/html/rfc1123)\", STD 3, RFC 1123, DOI 10.17487/RFC1123, October 1989.
  **\[RFC1535\]**   Gavron, E., \"[A Security Problem and Proposed Correction With Widely Deployed DNS Software](https://tools.ietf.org/html/rfc1535)\", RFC 1535, DOI 10.17487/RFC1535, October 1993.
  **\[RFC1536\]**   Kumar, A., Postel, J., Neuman, C., Danzig, P. and S. Miller, \"[Common DNS Implementation Errors and Suggested Fixes](https://tools.ietf.org/html/rfc1536)\", RFC 1536, DOI 10.17487/RFC1536, October 1993.
  **\[RFC2119\]**   Bradner, S., \"[Key words for use in RFCs to Indicate Requirement Levels](https://tools.ietf.org/html/rfc2119)\", BCP 14, RFC 2119, DOI 10.17487/RFC2119, March 1997.
  **\[RFC3397\]**   Aboba, B. and S. Cheshire, \"[Dynamic Host Configuration Protocol (DHCP) Domain Search Option](https://tools.ietf.org/html/rfc3397)\", RFC 3397, DOI 10.17487/RFC3397, November 2002.
  **\[RFC3646\]**   Droms, R., \"[DNS Configuration options for Dynamic Host Configuration Protocol for IPv6 (DHCPv6)](https://tools.ietf.org/html/rfc3646)\", RFC 3646, DOI 10.17487/RFC3646, December 2003.
  **\[RFC6106\]**   Jeong, J., Park, S., Beloeil, L. and S. Madanapalli, \"[IPv6 Router Advertisement Options for DNS Configuration](https://tools.ietf.org/html/rfc6106)\", RFC 6106, DOI 10.17487/RFC6106, November 2010.
  ----------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

[7.2.](#rfc.references.2) Informative References {#rfc.references.2}
================================================

  ---------------- --------------------------------------------------------------------------------------------------------------------------------------
  **\[SAC064\]**   \"[SAC064: SSAC Advisory on Search List Processing](https://www.icann.org/en/groups/ssac/documents/sac-064-en.pdf)\", February 2014.
  ---------------- --------------------------------------------------------------------------------------------------------------------------------------

[Appendix A.](#rfc.appendix.A) Changes / Author Notes. {#rfc.appendix.A}
======================================================

\[RFC Editor: Please remove this section before publication \]

From initial to -00.

-   Nothing changed in the template!

[Authors\' Addresses](#rfc.authors) {#rfc.authors}
===================================

::: {.avoidbreak}
[ [Andrew McConachie]{.fn} [ [McConachie]{.family-name} ]{.n .hidden}
]{.vcardline} [Internet Corporation for Assigned Names and Numbers]{.org
.vcardline} [ [12025 Waterfront Drive, Suite 300]{.vcardline} [ [Los
Angeles]{.locality}, []{.region} [90094]{.code} ]{.vcardline}
[USA]{.country-name .vcardline} ]{.adr} [Phone:
+1.310.301.5800]{.vcardline} [EMail:
<andrew.mccconachie@icann.org>]{.vcardline}
:::

::: {.avoidbreak}
[ [Warren Kumari]{.fn} [ [Kumari]{.family-name} ]{.n .hidden}
]{.vcardline} [Google]{.org .vcardline} [ [1600 Amphitheatre
Parkway]{.vcardline} [ [Mountain View, CA]{.locality}, []{.region}
[94043]{.code} ]{.vcardline} [USA]{.country-name .vcardline} ]{.adr}
[EMail: <warren@kumari.net>]{.vcardline}
:::
