Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:44071 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932292Ab2JLMxO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Oct 2012 08:53:14 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id B0462A2C8B
	for <util-linux@vger.kernel.org>; Fri, 12 Oct 2012 14:53:12 +0200 (CEST)
Date: Fri, 12 Oct 2012 14:53:09 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: util-linux@vger.kernel.org
Subject: Re: [util-linux] [PATCH 00/13] Initial import of sulogin
Message-ID: <20121012125309.GA20273@boole.suse.de>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
 <20120228164840.GH21406@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20120228164840.GH21406@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 28, 2012 at 11:48:40AM -0500, Dave Reisner wrote:
> On Tue, Feb 28, 2012 at 11:45:08AM -0500, Dave Reisner wrote:
> > This is an initial stab at importing sulogin from sysvinit and making it a bit
> > more universal. I've removed the distro specific code and brought the rest of
> > it more in line with the style of the remainder of the repo. I've also added
> > internationalization and cleaned up the manpage.
> 
> Err, forgot... these patches live in a repo below on the 'sulogin'
> branch:

Question: Why the code for multi console support was not included?
IMHO this is not distro specific code even if I've written this
code for sysvinit.

     Werner

-- 
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr
