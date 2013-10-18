Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16392 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801Ab3JRIey (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Oct 2013 04:34:54 -0400
Date: Fri, 18 Oct 2013 10:34:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Aleksey Midenkov <midenok@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Per-filesystem default mount options
Message-ID: <20131018083452.GB15115@x2.net.home>
References: <CAF8BazAW7xxXpO1-vCBJvfvORBLXnJkDxv=qagoe0ZJe-12aJg@mail.gmail.com>
 <CAF8BazDFWf7-NPwCr7Cg=aV9prKsWNUxJu2neZ3x+8XP1fZPHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAF8BazDFWf7-NPwCr7Cg=aV9prKsWNUxJu2neZ3x+8XP1fZPHQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 16, 2013 at 06:13:17PM +0400, Aleksey Midenkov wrote:
> Is it possible to specify per-filesystem default mount options
> somewhere in configuration file?

 /etc/fstab, or tune2fs for extN, or /etc/nsfmount.conf for NFS.

 The per-filesystem-type default options are also hardcoded in kernel.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
