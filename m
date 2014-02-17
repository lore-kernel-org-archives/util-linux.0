Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59235 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbaBQMhk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Feb 2014 07:37:40 -0500
Date: Mon, 17 Feb 2014 13:37:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: initialize *root to NULL in
 mnt_table_get_root_fs
Message-ID: <20140217123735.GF2254@x2.net.home>
References: <1392559086-4010-1-git-send-email-thomas@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1392559086-4010-1-git-send-email-thomas@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 16, 2014 at 02:58:06PM +0100, Thomas Bächler wrote:
>  libmount/src/tab.c | 1 +
>  1 file changed, 1 insertion(+)

 Applied with a small change, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
