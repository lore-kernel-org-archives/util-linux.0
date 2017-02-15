Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751813AbdBOMsV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 Feb 2017 07:48:21 -0500
Date: Wed, 15 Feb 2017 13:48:17 +0100
From: Karel Zak <kzak@redhat.com>
To: Alexander F =?iso-8859-1?Q?R=F8dseth?= <xyproto@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] rename: add --dry-run option
Message-ID: <20170215124817.jheiwl6wn4ux4b3x@ws.net.home>
References: <CAG7ayytqobZ3bkvvBJU01DOYNShLZkH8eYo2BZ_bzBShytjEJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAG7ayytqobZ3bkvvBJU01DOYNShLZkH8eYo2BZ_bzBShytjEJQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 13, 2017 at 03:08:39PM +0100, Alexander F Rødseth wrote:
> Added a --dry-run and -d option for not making changes when running
> the rename command. Also made changes to the man page.

Applied, but I have renamed the option --dry-run to --no-act to be
more compatible with another stuff in util-linux. 

(We also use --dry-run, but only for rtcwake.)

> Having a dry-run option is useful when running a scary rename.

Definitely, it's nice feature especially with --verbose.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
