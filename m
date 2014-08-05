Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f173.google.com ([209.85.192.173]:53687 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbaHEWia (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 5 Aug 2014 18:38:30 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so2095434pde.18
        for <util-linux@vger.kernel.org>; Tue, 05 Aug 2014 15:38:30 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140804120238.GB6923@x2.net.home>
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
	<20140804120238.GB6923@x2.net.home>
Date: Tue, 5 Aug 2014 23:38:29 +0100
Message-ID: <CAG27Bk2TNvGiwABgbJP=UqBGxZ=qhZoXCXOHRnuo3JHw8mABsA@mail.gmail.com>
Subject: Re: [PATCH 1/7] zramctl: print all devices as a default action
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 4 August 2014 13:02, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Aug 03, 2014 at 03:17:37PM +0100, Sami Kerola wrote:
>> This commit makes the command to display information about all zram
>> devices when the command is ran without any arguments.  Listing includes
>
>  I don't think it's a good idea do it by default. The current zramctl
>  follows the logic we use for losetup (or lsblk), it means "list all
>  used devices". I'm not sure if we really need to list empty devices,
>  such devices are /dev nodes only. Maybe we can add --all if you have
>  any use-case for this feature.

Sounds reasonable. I'll get rid of the commit by the time of next submission.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
