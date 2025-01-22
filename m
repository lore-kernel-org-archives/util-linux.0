Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6F4502A
	for <util-linux@vger.kernel.org>; Wed, 22 Jan 2025 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737542111; cv=none; b=rUIUO2ti1Qpz/Tw/WEXAPbrStqOLPmUYobva7uvaH+jrkoVsnngs2FIhqmacsuq//5fXCI/r4gQvuCkwwK1M7hdSPflx8pzV5jBwtCIENomoQu2OnjrXTU/2Xp1IVUfzXvsTkLff1pMiuagWJTfrwPZlWq6HFKjTnNATnedruro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737542111; c=relaxed/simple;
	bh=DLBxts4PC7SX06f9W2cb5008Zx7VWLH211+YFIpEpsg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fzgiQ9Pl/ohOWj9FMqfAr2UsewQ8daRWFFdu7Mu5ILOCByN37On1zNl3vxqHXLEjHWsjePz8kC6mqiQ08OyXCrtQOwHL8v7OOxZ+CqV/jXqQMmR/fnYpqWJkzPG7WXpVfVuoaJ1q7l9ymqgCVEMpwX2qR+YtjMGW9L9gjXtOqQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=marioecht@gmx.de header.b=Yzt9fmMr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=marioecht@gmx.de header.b="Yzt9fmMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1737542107; x=1738146907; i=marioecht@gmx.de;
	bh=DLBxts4PC7SX06f9W2cb5008Zx7VWLH211+YFIpEpsg=;
	h=X-UI-Sender-Class:MIME-Version:From:Date:Message-ID:Subject:To:
	 Content-Type:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=Yzt9fmMr3JSfFFP/KmhuO1VzQ+d78k+1HG0EjFiqrOZMIvl2ZddGmPmG/hatS9/P
	 MbnnSsJpcayRMlmGtGSoNHxCTjIqHK6juRUPTIFrj/HnQzo6RkghMiwjbzx76sgB3
	 +pBzpujIuR2HBWj0/WR07ZMsZ3q6yRRT2384n23x0823fGlmJ7v52KLOHR8AHPNo8
	 1z/Q6U0rNiJewK3RrPSPpdMg6Xn3vllkFD4u21By/Kxyt1X5Kywig8fWopOAofEPE
	 wOfS58QkpxB/K02qMeQkxxwYTIOeJcJEnuLPgLf9Rji9RRwbZF9ZDqlLqKvomHiAt
	 Ce3O3rlf+TBsp+wesw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mail-pl1-f174.google.com ([209.85.214.174]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MyKDU-1tHehr1GVY-012xAG for <util-linux@vger.kernel.org>; Wed, 22 Jan 2025
 11:35:07 +0100
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2156e078563so88339805ad.2
        for <util-linux@vger.kernel.org>; Wed, 22 Jan 2025 02:35:07 -0800 (PST)
X-Gm-Message-State: AOJu0Yx60JLkkh4lkrw4B7wAWTXILbrSs5AcXNJWT7CCWgMMRNaKwUKq
	E/ndUIaGnNye87Bt9+iACWGkaZQv83WLpsZTg2rr56g9wLWcoyZSoAzRIcukPtk2S2DL0lutHa1
	JSf1lmf/Wn2SbURVeN2cr7txHr7U=
X-Google-Smtp-Source: AGHT+IHtGQ+eqiWrZpMWxqjMjqwZVjVxzDVPfsK9XFjwj30s5ydA3h39/QOQZWjLbJzachMKDGrqv8Q1K5s6rvgTXHY=
X-Received: by 2002:a17:903:2282:b0:212:514:b30a with SMTP id
 d9443c01a7336-21c353ed2b9mr342733645ad.12.1737542105958; Wed, 22 Jan 2025
 02:35:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mario <marioecht@gmx.de>
Date: Wed, 22 Jan 2025 11:34:50 +0100
X-Gmail-Original-Message-ID: <CAFksh4PZbS_+t7QrOQB++xY_1cYc6Fx-4O1f6MPX3VCTf4-ijQ@mail.gmail.com>
X-Gm-Features: AbW1kvbDZxff0yXh5A9wtV4_zX3pQlbI0P4b6Clmc1TLp1S8dp82_uSsKM-vnc4
Message-ID: <CAFksh4PZbS_+t7QrOQB++xY_1cYc6Fx-4O1f6MPX3VCTf4-ijQ@mail.gmail.com>
Subject: License Combination: LGPL and BSD-4-Clause
To: util-linux@vger.kernel.org, dave@gnu.org, kerolasa@iki.fi, kzak@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hsWrJYCamLI81NPRY3eqoFqGesIPbMKE2s2aNZa79+kadoHYqNU
 SxIyiY7lhFaYOeyheYWSTw8LHgD3uLTyUfVsM6+J6RxKosvBA2X3a297xqVVYYUeot3BnIT
 dzMhmPK2HK4XB1rj5AKWv9yapvRuXLmTUTACbXzaZIf3R/eWKz9uE3cJWZqOVGGf7OKopB0
 Nyt66HEbLS2mLimWrYIQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wNE/eLkJI0o=;SuanY7Vgy7G1jB7LuGjSyciHeRz
 ssTsg7uL9n/6jk1lqM6Sxb6+9p0jgcT1hFJ16wdP7wpuHCyUc6d+sxPozoj84LBJZS5b9CNF6
 VGSnVHgl+6sHnNW1UfL/jhLITn07JhDOai6pVMX4TJW/sQ/+n+rTAvrvw8hzA1KSZhqRcBRM2
 bggXpIahtlpMxvMvBghP+BU6qq0bUD1+05x+wDN4Ywvl1E0eoWCsSXc7q1+rT1YxjokpLSk/6
 K/Dp3gs/TPDLITolwjGi7ROq65PjY1pskJ1nxWBWbAYhKw0iOuBK6c3WMIJhBmhhF3Q/1Nyd5
 DddrgaFRqZw4RaHx15S+cFYc74sbBy2KApoetLF2MbEnNUynynH34Zig2xn5lmh3OoNYDpfT+
 vK2Qt/PSUV0fhiSvLUjAyFznLJkU6VpKvhrSy1CGz6YrAHKHbuFy3xtzPdtDYug1pVLnRpmwE
 /IJKRryvS9yTgzgsvydOeSdzpacIREvhNIFO1hD9NAwP6SzsSgJDwARP49V4A4zW3nbX9LiTF
 bVFI00QmX4fPlBW7FQY/ywoYSsPKrW1OFZRXMqCZhai+Ehfqp6B3H5guZWCIIajP6EFXQfSH+
 KvgQpqiXrYTqMN+i7fx5/Qjx+6zdrR2qmgMGIFM4GRluM2nl13Ezb0ps4Ne2ToiS1ADEgbWUF
 0/g56CaVx0/qWgDWXRhVUxSPPgcjA5j17hjklGefm1LKDt1fn6xVlgZqj5rKv4milxrxEzMQJ
 Q1eFlzo3HQLMvGKwZIIDMjmDkdHqPZlUML2AU9YlTZhkq0CMoG8SJFnVfxpdrxQo7KdFoe5d5
 VpVdDLfCCh/aWojzfUa7r0BbLC0tiYylFBnP5dt38OW+2bEiQFZW0RG40vQrPVuKWOI+U0tKg
 TUmx9BP7ekSHc4m1QNu7AldHSCiynzA2Rd89U4ziVI4LMycsoKnEz/wtq6PdrrRTM/4Ggh50p
 To175BFbSBkVHf7JUUZtLaJUlr1R7q4wpCBmYXuE/He85PPolugUOCgHlA5ebHkPsr+0U+RcA
 cFZi2WELtdISSnP6tLS/6psqPllY5LB2rvwZIyWc8h6bfHnysUg2iDsVc92YGogWe4f35ouXF
 RoO9tu3H/qWQ/lMIHMlivrEJ4vvrT3UP1bQTq1FljxVnH7gm6lkTqPB7DnQT7t/u0N574I6iC
 gTOJbfavXtb889KhVdKV/NTSCdcQxlUQal3HmPA+WuUD+K7iOQ2QeYWuC3V4GAdr2Cm0sqMt4
 dsgiPZq0PG6lOqJEheNxlgAhroHQ/DNM8E+P+omez7+mRFZZXGpEAtlHAdm6+gOZ+243ua1HU
 F+MOscXVpg/w9COWTcRdTybwQ==

Hi there,

I have a question about the compatibility of two software licenses in
util-linux. Here is an example:

The file text-utils/hexdump-parse.c is licensed under the BSD-4-Clause license.
This file includes the header file include/xalloc.h, which is licensed
under the LGPL.

According to the GNU licence compatibility list
(https://www.gnu.org/licenses/license-list.html.en#OriginalBSD),
this combination of licenses is not allowed.

I would like to know:

How can the resulting binary from this combination be used in a
license-compliant manner?
Are there any possible solutions or workarounds to resolve the license
incompatibility?

Any insight or guidance on this matter would be greatly appreciated.

Thank you very much for your time.

Best regards,
Mario
