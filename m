Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48135 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463Ab2AQKH6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Jan 2012 05:07:58 -0500
Date: Tue, 17 Jan 2012 11:07:56 +0100
From: Karel Zak <kzak@redhat.com>
To: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: fdisk: off-by-one issue in (n)new command
Message-ID: <20120117100756.GA12310@x2.net.home>
References: <4F0E167A.9090205@yahoo.com.ar>
 <CAMFXF50uHCU4yhwe3byAsTKvPpi8F63mR9O4TfKhuANiEL_v0Q@mail.gmail.com>
 <4F149CA0.6040100@yahoo.com.ar>
 <4F14A512.2030904@yahoo.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F14A512.2030904@yahoo.com.ar>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 16, 2012 at 07:30:42PM -0300, Gerardo Exequiel Pozzi wrote:
> Last sector, +sectors or +size{K,M,G} (2048-524287, default 524287): +255M
> Value out of range.

 The size of the device is 268435456 bytes,

 +255M is relative to the begin of the partition, it means

    (2048 * 512) + (255 * 1024 * 1024) = 268435456 bytes

 but the begin of the last sector (in bytes) is

    268435456 - 512 = 268434944 bytes (LBA sector 524287)

 Right?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
