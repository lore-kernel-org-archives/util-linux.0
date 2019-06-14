Return-Path: <SRS0=yW9d=UN=oceandigihub.com=susan.jackson@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303B7C31E4B
	for <util-linux@archiver.kernel.org>; Fri, 14 Jun 2019 16:21:03 +0000 (UTC)
Received: from n1nlsmtp02.shr.prod.ams1.secureserver.net (n1nlsmtp02.prod.ams1.secureserver.net [188.121.43.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7122168B
	for <util-linux@archiver.kernel.org>; Fri, 14 Jun 2019 16:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=oceandigihub.com header.i=@oceandigihub.com header.b="hFwrgrBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7122168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oceandigihub.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=susan.jackson@oceandigihub.com
Received: from n3plcpnl0282.prod.ams3.secureserver.net ([160.153.155.37])
	by : HOSTING RELAY : with ESMTP
	id bovnhd3ZbOKpIbovnhlDfE; Fri, 14 Jun 2019 09:19:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oceandigihub.com; s=default; h=Content-Type:MIME-Version:Message-ID:Date:
	Subject:To:From:Reply-To:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oEBMdQWmzHflEcwv85CjQqHYzPccKBEKZ83rUljg7BE=; b=hFwrgrBwKTfhmcgso9JyJaMcuF
	XSWaS7twdDvWfF4sDIodCeIuFQcwtUQQ8OtssbxX+sfjNrQEf2PqZJzER6ehmODqDOpy/YjH79TtS
	EmSiAVMuNdi6jrPSg1fh/DJLjm/XIV2LCFS0QRnxu0FAP71xmT1bXEOXKW4lYtOMGWpZO47qSf9aP
	GoQGrFZrmDAWvGlZt5YcLxyhZhNFVjTWh7S/N/Tdfbi76+YvofiVxpeuKTc4DEb8h7IsxM3fTtLUh
	ndgCcMEQdkwsjnyFG7CFFJ+6T+Fe4ZipWFJnAqfJn9fRyMviWHeEAgd18c5qlI/YH8C5269k7XkZ6
	dnr+Q0sA==;
Received: from [107.150.51.170] (port=50528 helo=WS43)
	by n3plcpnl0282.prod.ams3.secureserver.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
	(Exim 4.92)
	(envelope-from <susan.jackson@oceandigihub.com>)
	id 1hbovm-0072Tm-88
	for util-linux@archiver.kernel.org; Fri, 14 Jun 2019 09:19:59 -0700
Reply-To: <susan.jackson@oceandigihub.com>
From: "Susan Jackson" <susan.jackson@oceandigihub.com>
To: <util-linux@archiver.kernel.org>
Subject: Docker Potential Business Lead
Date: Fri, 14 Jun 2019 21:48:55 +0530
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAADcaoiFjzWRGv7a5A5uXwzHCgAAAEAAAAPmOYvXDMOdAkyjr7PrsTP4BAAAAAA==@oceandigihub.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0583_01D522FB.19500D30"
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdUizNR3wur3uB7HTXODNYel8ek7/A==
Content-Language: en-us
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - n3plcpnl0282.prod.ams3.secureserver.net
X-AntiAbuse: Original Domain - archiver.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oceandigihub.com
X-Get-Message-Sender-Via: n3plcpnl0282.prod.ams3.secureserver.net: authenticated_id: susan.jackson@oceandigihub.com
X-Authenticated-Sender: n3plcpnl0282.prod.ams3.secureserver.net: susan.jackson@oceandigihub.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CMAE-Envelope: MS4wfEAHcLlQFtDTSK6BK3jN35oKPsV8VuCGSToj02MtR8Ek2Ma7C2q8mFmEjCXh7DFKBzYcnlx8e5ZnsQiORq533+/Ys7yHLUJQxmsrKL39Hn6yBDNWrfk+
 n92/3nMDxBfEo0Jntfq2by1D+HD5DtO+etQ8YU8jRO1qoEEZZK0//DEsMRqtkNHu7Jk/rk3ZjIV8L7K5aXGS+/lwme8zOSj7avqrYYnA6mJoLA6kwBZCUjqP
List-Id: <util-linux.vger.kernel.org>

This is a multipart message in MIME format.

------=_NextPart_000_0583_01D522FB.19500D30
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, 

Hope you are doing well!

I wanted to check if you'd be interested in purchasing 2019 updated Docker
User List for your marketing initiatives?

We also have related technology users like: Schneider, Salesforce, Oracle,
IBM, Cisco, Microsoft and many more...

Let me know if you are interested and I will get back to you with the Counts
and Pricing for your review.

Thanks and I look forward to hearing from you soon!

Regards 

Susan Jackson 

Sr. Marketing Manager



If you are not interested please reply with "Not Interested" In the Subject
Line.

 


------=_NextPart_000_0583_01D522FB.19500D30
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Helvetica;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:8.0pt;
	margin-left:0in;
	line-height:106%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.MsoNoSpacing, li.MsoNoSpacing, div.MsoNoSpacing
	{mso-style-priority:1;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
.MsoPapDefault
	{mso-style-type:export-only;
	margin-bottom:8.0pt;
	line-height:107%;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US><div =
class=3DWordSection1><p class=3DMsoNoSpacing><span =
style=3D'color:#4472C4;background:#FBFBFB'>Hi, </span><span =
style=3D'color:#4472C4'><br><br><span style=3D'background:#FBFBFB'>Hope =
you are doing well!</span><br><br><span style=3D'background:#FBFBFB'>I =
wanted to check if you&#8217;d be interested in purchasing 2019 =
updated<b> Docker </b><b>User List</b> for your marketing =
initiatives?</span><br><br><b><span style=3D'background:#FBFBFB'>We also =
have related technology users like:</span></b><span =
style=3D'background:#FBFBFB'> Schneider, Salesforce, Oracle, IBM, Cisco, =
Microsoft and many more...</span><br><br><span =
style=3D'background:#FBFBFB'>Let me know if you are <b>interested</b> =
and I will get back to you with the <b>Counts and Pricing</b> for your =
review.</span><br><br><span style=3D'background:#FBFBFB'>Thanks and I =
look forward to hearing from you soon!</span><br><br><b>Regards =
</b><o:p></o:p></span></p><p class=3DMsoNoSpacing><b><span =
style=3D'color:#4472C4'>Susan Jackson <o:p></o:p></span></b></p><p =
class=3DMsoNoSpacing><b><span style=3D'color:#4472C4'>Sr. Marketing =
Manager<o:p></o:p></span></b></p><p class=3DMsoNormal><span =
style=3D'color:#4472C4'><br></span><span =
style=3D'font-size:10.0pt;line-height:106%;font-family:"Helvetica",sans-s=
erif;color:#D0CECE'><br><span style=3D'background:#FBFBFB'>If you are =
not interested please reply with &#8220;Not Interested&#8221; In the =
Subject Line.</span></span><span =
style=3D'color:#4472C4'><o:p></o:p></span></p><p =
class=3DMsoNoSpacing><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_0583_01D522FB.19500D30--

