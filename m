Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34269 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753240AbcIZWgr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 26 Sep 2016 18:36:47 -0400
Received: by mail-qt0-f171.google.com with SMTP id 38so91120589qte.1
        for <util-linux@vger.kernel.org>; Mon, 26 Sep 2016 15:36:47 -0700 (PDT)
Date: Mon, 26 Sep 2016 18:36:45 -0400
From: Dave Reisner <d@falconindy.com>
To: Andreas Fenkart <afenkart@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: getmntent wrapper?
Message-ID: <20160926223645.GB13829@rampage>
References: <CALtMJED52KKWgMmg+hcGavZAP6fwh_AbTWFZKz+LYEWszsjLJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALtMJED52KKWgMmg+hcGavZAP6fwh_AbTWFZKz+LYEWszsjLJw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 27, 2016 at 12:25:32AM +0200, Andreas Fenkart wrote:
> Hi,
> 
> Parsing /etc/fstab or /proc/mount with sed/awk is awful and platform
> dependent. Would it be acceptable to add a wrapper for getmntent to
> parse those files and make the content available to shell scripts?
> 
> Typical use is to check if a given device is already mounted and
> returning its mountpoint. In case a device is mounted twice or more,
> several mountpoints will be listed
> 
> $ getmntent -f /proc/mounts /dev/sda4
> /mnt/
> /home/user/bind
> 
> Playing around with mount parsing the output with awk seems to work
> pretty well. It avoids to handle the whitespace separately.
> 
> $ mount -l  | awk  '/\/dev\/sda4/ { print $3; }'
> 
> negative:
> - I can't use the a different filesystem description file (small minus)
> - Is the output from 'mount' stable?
> 
> Is it worth to add a utility wrapper for getmntent to util-linux?

This sort of functionality already exists in findmnt(1).

$ findmnt -rno TARGET /dev/sdc1
/mnt/Haven
/srv/nfs/pkgs
/srv/nfs/vmbin
