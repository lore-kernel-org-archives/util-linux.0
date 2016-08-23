Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36788 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754489AbcHWDDa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 22 Aug 2016 23:03:30 -0400
Received: by mail-wm0-f46.google.com with SMTP id q128so145037347wma.1
        for <util-linux@vger.kernel.org>; Mon, 22 Aug 2016 20:03:29 -0700 (PDT)
Received: from [192.168.0.76] (cpe-70-123-244-133.satx.res.rr.com. [70.123.244.133])
        by smtp.gmail.com with ESMTPSA id a9sm1229383wjf.16.2016.08.22.20.03.27
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2016 20:03:27 -0700 (PDT)
To: Util linux <util-linux@vger.kernel.org>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: listing fdisk partition tyles
Message-ID: <57BBBCFD.9090502@gmail.com>
Date: Mon, 22 Aug 2016 22:03:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I have a request.  When I try to install Debian from an iso, I like to 
drop to the command line to run fdisk to partition the disk drive.  When 
selecting GPT, I have a problem with listing the partition types.

The screen is running at about 80x25 and I have no control over that.
The l command lists all the 81 types and there is no way to scroll back to 
see the first 55 entries in the list.

There is no problem when listing partition types when the partition table 
is the old MSDOS type,

I would like to request a pager, possibly as an option, for the partition 
type list when using a GPT partition table.

Thanks.

   -- Bruce Dubbs
      linuxfromscratch.org
