Return-Path: <SRS0=BYqf=Y7=ultramicroeventmediazone.com=carmen.leiser@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5F0C43331
	for <util-linux@archiver.kernel.org>; Thu,  7 Nov 2019 21:33:55 +0000 (UTC)
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net (a2nlsmtp01-02.prod.iad2.secureserver.net [198.71.225.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADB721D79
	for <util-linux@archiver.kernel.org>; Thu,  7 Nov 2019 21:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ultramicroeventmediazone.com header.i=@ultramicroeventmediazone.com header.b="dykeFFTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADB721D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ultramicroeventmediazone.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=carmen.leiser@ultramicroeventmediazone.com
Received: from a2plcpnl0464.prod.iad2.secureserver.net ([198.71.235.60])
	by : HOSTING RELAY : with ESMTP
	id SpOfiJt7d6kPlSpOfizS7H; Thu, 07 Nov 2019 14:32:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ultramicroeventmediazone.com; s=default; h=Content-Type:MIME-Version:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=xmY7jOgyxRd+AkN39yydnfjAh0tZ/oQ5aoNZmKxlZww=; b=dykeFFTBSByHVHCCTygs7IjmH
	C+sXHkEsrrxFmSz5a/gUh9ruJXXlrKlq+4aGlC/KfxaTNsknAp1KmBRapupEAyjahX3GPSWBD89bD
	MJB9/YHEYnJYA3rHNLZHCut7x/CoPfPOLNUrlJHvvIbxvAY0iqKAoSiyqChJ8NDKX/OhqE5elS1n1
	zL9M8ZEUXdVJmwu4uZbR5eD9GwgZCMnt5W1BMXTgdxtKV06hjjIOO87g9c0rGvP/wNbsyW4+vpBoT
	ssiThforOFIb43W+2rxofRwzHf/I87BG/2PrHcse1G6332kGob5gkgz8xIfVKh/Pw1sTyGCKF1C1T
	SIYZ7PjQA==;
Received: from [192.171.255.39] (port=52423 helo=WS56)
	by a2plcpnl0464.prod.iad2.secureserver.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.92)
	(envelope-from <carmen.leiser@ultramicroeventmediazone.com>)
	id 1iSomB-001psd-SB
	for util-linux@archiver.kernel.org; Thu, 07 Nov 2019 13:53:08 -0700
From: "Carmen Leiser" <carmen.leiser@ultramicroeventmediazone.com>
To: <util-linux@archiver.kernel.org>
Subject: Docker Users List 
Date: Fri, 8 Nov 2019 02:10:46 +0530
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAOMR9t8DIDpGt6zYQkJwBvHCgAAAEAAAAHJgQIQb0+BFuSKBhcfuf5EBAAAAAA==@ultramicroeventmediazone.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_57F7_01D595DB.6F8D5F10"
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdWVqwmFl/A0k6pBQ8Ks3DH6F52xVw==
Importance: High
Content-Language: en-us
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - a2plcpnl0464.prod.iad2.secureserver.net
X-AntiAbuse: Original Domain - archiver.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - ultramicroeventmediazone.com
X-Get-Message-Sender-Via: a2plcpnl0464.prod.iad2.secureserver.net: authenticated_id: carmen.leiser@ultramicroeventmediazone.com
X-Authenticated-Sender: a2plcpnl0464.prod.iad2.secureserver.net: carmen.leiser@ultramicroeventmediazone.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CMAE-Envelope: MS4wfJ5iwYlj0ZqugujJzj8rjrXdMank3dJD6HsAY2UlKFKqlDevceC7teixBTWHttUqnVqv3/n9wWHM06WS92IGo3dCFaO9nSxlrQ0L2BCR61K2I0jcad+6
 1NV3yMMaVGooDPYQ2+MiFz1cwJXm0RRx1rBLKB1asa9tLCGmUv5VV6SDuhXrj9kGhPBjAB2Z9Cf+T9yO5plWUgBoW9VmWHB88iBZDxImNL15yE3vgj8H5sR1
 1xq8oNxhz+xQFioJ0Gs5WQ==
List-Id: <util-linux.vger.kernel.org>

This is a multipart message in MIME format.

------=_NextPart_000_57F7_01D595DB.6F8D5F10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Hope you are doing well!

I'm Curious to know if you'd be interested in acquiring Docker Users List
for your sales and marketing Initiatives?

We also have related technology users like: VMware, Container, Containerd,
Kubernetes, Jenkins, Vagrant, Hypervisor, Openshift and many more.

Currently we are running the Q4 discounted offer. Let me know if you are
interested and I will get back to you with Counts, Pricing and Samples for
your review.


Thanks and I look forward to hearing from you soon!

Regards 

Carmen Leiser

Sr. Marketing Manager

If you are not interested please reply with "Not Interested" In the Subject
Line.

 

 


------=_NextPart_000_57F7_01D595DB.6F8D5F10
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
	line-height:107%;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
p.MsoNoSpacing, li.MsoNoSpacing, div.MsoNoSpacing
	{mso-style-priority:1;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
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
class=3DWordSection1><p class=3DMsoNoSpacing =
style=3D'margin-bottom:12.0pt'><span =
style=3D'color:#002060;background:#FBFBFB'>Hi,</span><span =
style=3D'color:#002060'><br><br><span style=3D'background:#FBFBFB'>Hope =
you are doing well!</span><br><br><span =
style=3D'background:#FBFBFB'>I&#8217;m Curious to know if you&#8217;d be =
interested in acquiring <b>Docker Users List</b> for your sales and =
marketing Initiatives?</span><b><o:p></o:p></b></span></p><p =
class=3DMsoNoSpacing><b><span =
style=3D'color:#002060;background:#FBFBFB'>We also have related =
technology users like:</span></b><span =
style=3D'color:#002060;background:#FBFBFB'> VMware, Container, =
Containerd, Kubernetes, Jenkins, Vagrant, Hypervisor, Openshift and many =
more&#8230;</span><span style=3D'color:#002060'><br><br>Currently we are =
running the Q4 discounted offer. Let me know if you are interested and I =
will get back to you with <b>Counts, Pricing and Samples</b> for your =
review.<o:p></o:p></span></p><p class=3DMsoNoSpacing><span =
style=3D'color:#002060'><br><span style=3D'background:#FBFBFB'>Thanks =
and I look forward to hearing from you soon!</span><br><br><b>Regards =
<o:p></o:p></b></span></p><p class=3DMsoNoSpacing><b><span =
style=3D'color:#002060;background:#FBFBFB'>Carmen Leiser</span><span =
style=3D'color:#002060'><o:p></o:p></span></b></p><p =
class=3DMsoNoSpacing><b><span style=3D'color:#002060'>Sr. Marketing =
Manager<o:p></o:p></span></b></p><p class=3DMsoNoSpacing><span =
style=3D'font-size:8.0pt;font-family:"Helvetica","sans-serif";color:#AEAA=
AA;background:#FBFBFB'> <o:p></o:p></span></p><p =
class=3DMsoNoSpacing><span =
style=3D'font-size:8.0pt;font-family:"Helvetica","sans-serif";color:#AEAA=
AA;background:#FBFBFB'>If you are not interested please reply with =
&#8220;Not Interested&#8221; In the Subject Line.</span><span =
style=3D'font-size:8.0pt'><o:p></o:p></span></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_57F7_01D595DB.6F8D5F10--

