Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27091 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103AbaGUI3K (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Jul 2014 04:29:10 -0400
Date: Mon, 21 Jul 2014 10:28:59 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigbrady.com>
Subject: Re: mount.8: mtab as symlink
Message-ID: <20140721082859.GD17373@x2.net.home>
References: <53CCADA9.3020703@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53CCADA9.3020703@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 21, 2014 at 08:05:29AM +0200, Bernhard Voelker wrote:
>   It is  possible to replace /etc/mtab by a symbolic link to
>   /proc/mounts, and especially when you have very large numbers
>   of mounts things will be much faster with that symlink, but some
>   information is lost that way, and in particular using the "user"
>   option will fail.
> 
> ... and is scared about the last sentence.
> Is this still true? I don't have problems with mounting "user"
 
  Oops, this is really obsolete info. Fixed. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
