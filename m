Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755498AbdLOJfP (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 15 Dec 2017 04:35:15 -0500
Date: Fri, 15 Dec 2017 10:35:11 +0100
From: Karel Zak <kzak@redhat.com>
To: Frank Rowand <frowand.list@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: what is license policy
Message-ID: <20171215093511.3ucb3up5kvziml2i@ws.net.home>
References: <0e683b47-5a35-7633-bb03-992005040d07@gmail.com>
 <895195ca-2a1a-1b4a-a7c1-16ecb671e553@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <895195ca-2a1a-1b4a-a7c1-16ecb671e553@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 14, 2017 at 02:24:23PM -0800, Frank Rowand wrote:
> On 12/05/17 17:01, Frank Rowand wrote:

 Hmm... I don't see this mail in my mail storage. Sorry, for the
 delay.

> > I am trying to understand some things about the license policy for util-linux.
> > 
> > Can you please either confirm or correct what I think I have figured out from
> > reading files in the repo and reading the mail list archive:
> > 
> >   - GPL v3 is discouraged
> >   - but GPL v3 files will be accepted
> >   - replacing a GPL v3 file with a GPLv2+, GPLv2, LGPLv2+, BSD with advertising,
> >     or Public Domain license is a valid reason to replace an existing file

 Well, the current list of licenses is already large and I prefer to
 not introduce anything else if possible. 
 
 We did a change from GPLv3 to LGPLv2+ for one file in lib/ to keep it
 more usable as a library and GPLv3 to GPLv2 for lscpu. The change has
 been always accepted by code authors. 
 
 The util-linux package is random collection of very different tools
 with different licenses and we want to keep all the code usable
 together... (this is also reason why licenses are not our favorite
 topic ;-))

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
