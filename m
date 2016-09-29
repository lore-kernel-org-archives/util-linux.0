Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbcI2Jz5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Sep 2016 05:55:57 -0400
Date: Thu, 29 Sep 2016 11:55:53 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>
Cc: Stanislav Brabec <sbrabec@suse.cz>,
        util-linux <util-linux@vger.kernel.org>, linux-cifs@vger.kernel.org,
        Steve French <smfrench@gmail.com>
Subject: Re: [PATCH] libmount: Special handling of root comparison for cifs
 in mnt_table_is_fs_mounted()
Message-ID: <20160929095553.2f6g4b2mutotqi2r@ws.net.home>
References: <91d465d3-4f5b-6270-a6c5-38bd94695731@suse.cz>
 <5eb96b3e-d463-bf11-49de-f614247d6b29@suse.cz>
 <20160805192234.2c9d5b7d@aaptelpc>
 <7c2181d1-c7b5-df04-0640-ec23f5d78eab@suse.cz>
 <c4f10081-4525-4ac0-0e6b-b364c7268200@suse.cz>
 <eec8f575-eab2-34bb-882a-11fb8c33d9c0@suse.cz>
 <mpsbn06ruwv.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <mpsbn06ruwv.fsf@suse.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 02, 2016 at 08:58:08PM +0200, Aurélien Aptel wrote:
> I'm attaching a simpler patch that makes uses of streq_paths() in
> lib/strutils.c (Note: streq_paths() and next_path_segment() have to be
> backported for older versions of util-linux).
> 
>
> From a29acba1a7c71cdbfc1cc98f2905bfaf19b97a29 Mon Sep 17 00:00:00 2001
> From: Aurelien Aptel <aaptel@suse.com>
> Date: Thu, 1 Sep 2016 13:57:42 +0200
> Subject: [PATCH] libmount/src/tab.c: fix mount -a for cifs

 Applied, thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
