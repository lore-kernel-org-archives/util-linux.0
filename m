Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39720 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab2ATOVk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 20 Jan 2012 09:21:40 -0500
Received: by bkas6 with SMTP id s6so474215bka.19
        for <util-linux@vger.kernel.org>; Fri, 20 Jan 2012 06:21:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F158BD6.1020006@yahoo.com.ar>
References: <4F0E167A.9090205@yahoo.com.ar>
	<CAMFXF50uHCU4yhwe3byAsTKvPpi8F63mR9O4TfKhuANiEL_v0Q@mail.gmail.com>
	<4F149CA0.6040100@yahoo.com.ar>
	<4F14A512.2030904@yahoo.com.ar>
	<20120117100756.GA12310@x2.net.home>
	<4F158BD6.1020006@yahoo.com.ar>
Date: Fri, 20 Jan 2012 15:21:39 +0100
Message-ID: <CAMFXF52Crx7NSWWNSxgw-4FAyhQp7P5y50n7YBmRB+8PCvQwpg@mail.gmail.com>
Subject: Re: fdisk: off-by-one issue in (n)new command
From: Francesco Cosoleto <cosoleto@gmail.com>
To: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I wonder whether this is a preferred behavior:

Partition number (1-4, default 1): 5
Value 5 out of range, used 4.
First sector (2048-16383, default 2048): 1024
Value 1024 out of range, used 2048.
Last sector, +sectors or +size{K,M,G} (2048-16383, default 16383): +8M
Value 18432 out of range, used 16383.
Partition 4 of type Linux and of size 7 MiB is set

Francesco
