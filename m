Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13188 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755057AbaDGKnI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Apr 2014 06:43:08 -0400
Date: Mon, 7 Apr 2014 12:43:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: add systemd units
Message-ID: <20140407104304.GJ22126@x2.net.home>
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1396561311-12825-1-git-send-email-thomas@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 03, 2014 at 11:41:51PM +0200, Thomas Bächler wrote:
>  sys-utils/.gitignore        |  1 +
>  sys-utils/Makemodule.am     |  6 ++++++
>  sys-utils/fstrim.service.in |  6 ++++++
>  sys-utils/fstrim.timer      | 10 ++++++++++
>  4 files changed, 23 insertions(+)
>  create mode 100644 sys-utils/fstrim.service.in
>  create mode 100644 sys-utils/fstrim.timer

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
