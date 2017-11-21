Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751802AbdKULQo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 21 Nov 2017 06:16:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BAD46356D4
        for <util-linux@vger.kernel.org>; Tue, 21 Nov 2017 11:16:44 +0000 (UTC)
Date: Tue, 21 Nov 2017 12:16:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] lsns: add netnsid column
Message-ID: <20171121111641.dt3vodjsuwwnna6g@ws.net.home>
References: <20171115025920.22394-1-yamato@redhat.com>
 <20171115110922.c4vufqiglnipyayn@ws.net.home>
 <20171116.032439.1733506489064928691.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171116.032439.1733506489064928691.yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 16, 2017 at 03:24:39AM +0900, Masatake YAMATO wrote:
> By parsing this file (with libmount), we can say
> /run/netns/UTIL-LINUX-LSNS-TEST-NS is the logical name for
> net:[4026532562] either the mount point is created by ip command or
> not.

Nice. Yes, all you need is:

   tab = mnt_new_table_from_file(_PATH_PROC_MOUNTINFO);

.. see for example sys-utils/fstrim.c, and mnt_fs_get_fstype() and
mnt_fs_get_source().

> "ip link show" still uses netnsid, so I think my patch still makes
> sense. However, as you wrote, making a column for logical name,
> is more useful. It is not limited to net namespace.
> 
> A namespace can have more than one logical names.
> I wonder how to print them in a column.

libsmart supports multi-line cells:

 * use SCOLS_FL_WRAP for the column

 * set wrap function, for example in lsns.c: init_scols_table():

      cl =  scols_table_new_column(tab, col->name, col->whint, flags)
 
      if (flags & SCOLS_FL_WRAP) {
                scols_column_set_wrapfunc(cl,
                                scols_wrapnl_chunksize,
                                scols_wrapnl_nextchunk,
                                NULL);
                scols_column_set_safechars(cl, "\n");
      }


 * and in add_scols_line() where you compose output add to the table
   string where namespace names are separated by '\n', e.g. "aaa\nbbb"


This feature should be probably disabled for --raw, maybe add --nowrap
and in this case use "," as separator and remove SCOLS_FL_WRAP for the
column in init_scols_table().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
