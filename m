Return-Path: lennart@poettering.net
Date: Thu, 14 Jul 2011 14:40:34 +0200
From: Lennart Poettering <lennart@poettering.net>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: dmesg(1) changes
Message-ID: <20110714124034.GB23998@tango.0pointer.de>
References: <20110714115231.GF3486@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110714115231.GF3486@nb.net.home>
List-ID: <util-linux.vger.kernel.org>

On Thu, 14.07.11 13:52, Karel Zak (kzak@redhat.com) wrote:

>  * add --facility=<LIST> option to filter out messages, for example:
> 
>     $ dmesg --facility=daemon,user
>     [    1.802065] dracut: dracut-009-11.fc15
>     [    1.811267] dracut: rd.luks=0: removing cryptoluks activation
>     [    1.813913] dracut: rd.lvm=0: removing LVM activation
>     [    1.819348] udev[111]: starting version 167
> 
> 
> Comments & suggestions?

This is really cool! Thanks a lot for implementing this!

One last thing on my wishlist: "dmesg -k" as alias for "dmesg
--facility=kern", just to make this presumably very often requested
switch is easy to reach.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
