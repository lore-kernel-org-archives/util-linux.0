Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36264 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752857AbcHZRUu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 26 Aug 2016 13:20:50 -0400
Received: by mail-wm0-f47.google.com with SMTP id q128so1382157wma.1
        for <util-linux@vger.kernel.org>; Fri, 26 Aug 2016 10:20:50 -0700 (PDT)
Subject: Re: listing fdisk partition tyles
To: Karel Zak <kzak@redhat.com>
Cc: Util linux <util-linux@vger.kernel.org>
References: <57BBBCFD.9090502@gmail.com>
 <20160826110347.owpfzwvaynvzy3ib@ws.net.home>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <57C07911.30005@gmail.com>
Date: Fri, 26 Aug 2016 12:14:57 -0500
MIME-Version: 1.0
In-Reply-To: <20160826110347.owpfzwvaynvzy3ib@ws.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Mon, Aug 22, 2016 at 10:03:25PM -0500, Bruce Dubbs wrote:
>> I have a request.  When I try to install Debian from an iso, I like to drop
>> to the command line to run fdisk to partition the disk drive.  When
>> selecting GPT, I have a problem with listing the partition types.
>>
>> The screen is running at about 80x25 and I have no control over that.
>> The l command lists all the 81 types and there is no way to scroll back to
>> see the first 55 entries in the list.
>>
>> There is no problem when listing partition types when the partition table is
>> the old MSDOS type,
>>
>> I would like to request a pager, possibly as an option, for the partition
>> type list when using a GPT partition table.
>
> Implemented. Try it.
>
> It's enabled for strings based partition types (=GPT) only.

It works well for me.  Thanks.

The only suggestion I have is that the prompt might be more informative 
than just a colon.  Perhaps something like "(space for more; q to quit):" 
would be useful.  I do see that up and down arrows/page work also.

That's not essential though.

   -- Bruce

