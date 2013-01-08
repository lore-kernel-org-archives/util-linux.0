Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39264 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755827Ab3AHNSN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Jan 2013 08:18:13 -0500
Date: Tue, 8 Jan 2013 14:17:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Cristian =?iso-8859-1?Q?Rodr=EDguez?= <crrodriguez@opensuse.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] include/bitops.h: Use the operating system byteswapping
 functions
Message-ID: <20130108131729.GE18204@x2.net.home>
References: <1356543501-7033-1-git-send-email-crrodriguez@opensuse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1356543501-7033-1-git-send-email-crrodriguez@opensuse.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 26, 2012 at 02:38:21PM -0300, Cristian Rodríguez wrote:
> There is no need to reinvent the wheel.

 Well, htoXX function were added to glibc in version 2.9 (2009?), our
 bitops.h is probably older.

 Anyway, you're right that use libc implementation is good idea. I
 have merged both patches and applied with some changes.
 
 Please, use Signed-off-by: next time.

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
