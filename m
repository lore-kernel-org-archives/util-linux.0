Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:61752 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934061AbaGXHcc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 24 Jul 2014 03:32:32 -0400
Date: Thu, 24 Jul 2014 09:32:22 +0200
From: Karel Zak <kzak@redhat.com>
To: "Linda A. Walsh" <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Q: (RFE?)  How do you specify the 'no-canonicalize' option in
 fstab?
Message-ID: <20140724073222.GI26781@x2.net.home>
References: <53D08C77.6010500@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53D08C77.6010500@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 23, 2014 at 09:32:55PM -0700, Linda A. Walsh wrote:
> While it works interactively, that leaves out using it when most of the file
> systems are loaded -- how can one specify -no-canonicalize in /etc/fstab?

 Why do you want something like this? 
 
 The option --no-canonicalize has very special purpose (e.g. when
 mount.<type> helper calls mount(8)).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
