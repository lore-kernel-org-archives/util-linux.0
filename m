Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52423 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeFBABA (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 1 Jun 2018 20:01:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id 18-v6so5762829wml.2
        for <util-linux@vger.kernel.org>; Fri, 01 Jun 2018 17:00:59 -0700 (PDT)
Date: Sat, 2 Jun 2018 02:00:56 +0200 (CEST)
From: "Francisco J. Tsao Santin" <tsao@gpul.org>
Reply-To: tsao@gpul.org
To: Kevin Fenzi <kevin@scrye.com>
cc: Ruediger Meier <sweet_f_a@gmx.de>, Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>, tsao@fedoraproject.org
Subject: Re: hardlink util -- files de-duplication
In-Reply-To: <8f042d0b-ad2a-59aa-ac5d-69e6c197da02@scrye.com>
Message-ID: <alpine.LFD.2.21.1806020132110.21500@gilfoyle>
References: <20180601113807.ghf6dtcd5xa6qptu@ws.net.home> <201806011508.38470.sweet_f_a@gmx.de> <8f042d0b-ad2a-59aa-ac5d-69e6c197da02@scrye.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463769851-650195839-1527897658=:21500"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463769851-650195839-1527897658=:21500
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 1 Jun 2018, Kevin Fenzi wrote:

> On 06/01/2018 06:08 AM, Ruediger Meier wrote:
> > On Friday 01 June 2018, Karel Zak wrote:
> >> the util is little bit orphaned, what about to add this util to
> >> util-linux to make it available for another distros and keep it
> >> maintained in serious way? ;-)
> > 
> 
> I've also added my co-maintainer (tsao@fedoraproject.org).
> He's done most of the recent work on it, I haven't had time to do much
> with it at all.

Yep, I would like having more time to improve a bit the tool but... I
only added some patches for bugfixing.

> 
> I'd personally be in favor of it moving into util-linux. Hopefully it
> would get more time and attention there and more widespread use.
> 
> If tsao agrees, lets make it happen.

Good for me too :-) I only want to point a little issue: I suppose you know,
there is another hardlink tool with similar functions, and (re)written in
python by the Debian people[1][2]. In fact, the name of the file is the
same (but they are placed in different paths, /usr/bin vs /usr/sbin).
I hope it doesn't cause a distro-war ;-)
 
[1] https://packages.debian.org/sid/utils/hardlink
[2] https://jak-linux.org/projects/hardlink/
-- 
Francisco Javier Tsao Santín
http://gattaca.es
1024D/71CF4D62  42 F1 53 35 EF 98 98 8A FC 6C 56 B3 4C A7 7D FB
---1463769851-650195839-1527897658=:21500--
