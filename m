Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbdKULgf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 21 Nov 2017 06:36:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DAF41214D
        for <util-linux@vger.kernel.org>; Tue, 21 Nov 2017 11:36:35 +0000 (UTC)
Date: Tue, 21 Nov 2017 20:36:33 +0900 (JST)
Message-Id: <20171121.203633.949035400852899096.yamato@redhat.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] lsns: add netnsid column
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20171121111641.dt3vodjsuwwnna6g@ws.net.home>
References: <20171115110922.c4vufqiglnipyayn@ws.net.home>
        <20171116.032439.1733506489064928691.yamato@redhat.com>
        <20171121111641.dt3vodjsuwwnna6g@ws.net.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

So, my biggest question is "should I send an updated version of patch?" :-)

You wrote in https://marc.info/?l=util-linux-ng&m=151074416720085&w=2:
>  I'm ready to do all the changes (you don't have to resend the patch).

I think you may have improved version of code.
I would like to start from it for reflecting the new comments (if I should do).

Masatake YAMATO


> On Thu, Nov 16, 2017 at 03:24:39AM +0900, Masatake YAMATO wrote:
>> By parsing this file (with libmount), we can say
>> /run/netns/UTIL-LINUX-LSNS-TEST-NS is the logical name for
>> net:[4026532562] either the mount point is created by ip command or
>> not.
> 
> Nice. Yes, all you need is:
> 
>    tab = mnt_new_table_from_file(_PATH_PROC_MOUNTINFO);
> 
> .. see for example sys-utils/fstrim.c, and mnt_fs_get_fstype() and
> mnt_fs_get_source().
> 
>> "ip link show" still uses netnsid, so I think my patch still makes
>> sense. However, as you wrote, making a column for logical name,
>> is more useful. It is not limited to net namespace.
>> 
>> A namespace can have more than one logical names.
>> I wonder how to print them in a column.
> 
> libsmart supports multi-line cells:
> 
>  * use SCOLS_FL_WRAP for the column
> 
>  * set wrap function, for example in lsns.c: init_scols_table():
> 
>       cl =  scols_table_new_column(tab, col->name, col->whint, flags)
>  
>       if (flags & SCOLS_FL_WRAP) {
>                 scols_column_set_wrapfunc(cl,
>                                 scols_wrapnl_chunksize,
>                                 scols_wrapnl_nextchunk,
>                                 NULL);
>                 scols_column_set_safechars(cl, "\n");
>       }
> 
> 
>  * and in add_scols_line() where you compose output add to the table
>    string where namespace names are separated by '\n', e.g. "aaa\nbbb"
> 
> 
> This feature should be probably disabled for --raw, maybe add --nowrap
> and in this case use "," as separator and remove SCOLS_FL_WRAP for the
> column in init_scols_table().
> 
>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
