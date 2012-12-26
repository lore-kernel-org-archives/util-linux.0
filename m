Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f46.google.com ([209.85.219.46]:65388 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab2LZTCl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 26 Dec 2012 14:02:41 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so8291836oag.19
        for <util-linux@vger.kernel.org>; Wed, 26 Dec 2012 11:02:41 -0800 (PST)
Message-ID: <50DB499F.10008@opensuse.org>
Date: Wed, 26 Dec 2012 16:01:51 -0300
From: =?UTF-8?B?Q3Jpc3RpYW4gUm9kcsOtZ3Vleg==?= <crrodriguez@opensuse.org>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] include/bitops.h: Use the operating system byteswapping
 functions
References: <1356543501-7033-1-git-send-email-crrodriguez@opensuse.org> <201212261348.01760.vapier@gentoo.org>
In-Reply-To: <201212261348.01760.vapier@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed 26 Dec 2012 03:48:01 PM CLST, Mike Frysinger wrote:
> On Wednesday 26 December 2012 12:38:21 Cristian Rodríguez wrote:
>> There is no need to reinvent the wheel.
>
> the trouble is that util-linux supports more than linux, and the api of these
> funcs isn't the same (or even available) on other systems
> -mike

That's easy to fix. I will send a follow up patch later.

