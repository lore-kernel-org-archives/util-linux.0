Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ot0-f172.google.com ([74.125.82.172]:44701 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756667AbeATVB1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 20 Jan 2018 16:01:27 -0500
Received: by mail-ot0-f172.google.com with SMTP id t20so4355240ote.11
        for <util-linux@vger.kernel.org>; Sat, 20 Jan 2018 13:01:27 -0800 (PST)
Subject: Re: Problem building util-linux without a separate ncursesw include
 dir
To: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>,
        Karel Zak <kzak@redhat.com>,
        Carlos Santos <casantos@datacom.ind.br>,
        util-linux@vger.kernel.org
References: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br>
 <1705151756.2691717.1501548399616.JavaMail.zimbra@datacom.ind.br>
 <20170801072017.yl7mgv64pq7ccj5e@ws.net.home> <20180119024717.GJ7217@vapier>
 <20180119094051.g3qztrrqf5guife5@ws.net.home> <20180119182123.GK28967@vapier>
 <9f4f0155-fd38-e8d7-1340-b128b6ac447f@gmx.de>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <a752e108-f9ce-58cb-eb1f-f176b20a1989@gmail.com>
Date: Sat, 20 Jan 2018 15:01:25 -0600
MIME-Version: 1.0
In-Reply-To: <9f4f0155-fd38-e8d7-1340-b128b6ac447f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Rüdiger Meier wrote:
> On 01/19/2018 07:21 PM, Mike Frysinger wrote:
>> On 19 Jan 2018 10:40, Karel Zak wrote:
>>> On Thu, Jan 18, 2018 at 09:47:17PM -0500, Mike Frysinger wrote:
>>>> On 01 Aug 2017 09:20, Karel Zak wrote:
>>>>> On Mon, Jul 31, 2017 at 09:46:39PM -0300, Carlos Santos wrote:

[trim]

>>> The ncurses detection and variability in distros is horrible. We
>>> already tried all possible combinations and always someone complains
>>> about the way how we detect ncurses. See mailing list archive for more
>>> information.
>>
>> that's the point of pkg-config.  if someone is having problems because
>> they're doing something weird/non-standard, tell them to sort out their
>> pkg-config installs.
> 
> non-standard is to have ncurses.pc installed. Also cross-compiling is
> certainly more "weird" than not cross-compiling. Regarding "tell them",
> Have you tried yet to ask ncurses upstream about installing *.pc files
> by default?

In linuxfromscratch we build ncurses with the --enable-widec switch.  We 
then add

ln -sfv ncursesw.pc    /usr/lib/pkgconfig/ncurses.pc
ln -sfv libncurses.so  /usr/lib/libcurses.so

We have never had a problem with util-linux.  I'm not sure how other 
distros do it, but the above may give some clues about the original problem.

We do some other things too (we support a separate /usr partition) but the 
ncurses build is at

http://www.linuxfromscratch.org/lfs/view/stable/chapter06/ncurses.html

   -- Bruce
