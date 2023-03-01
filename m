Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470EEC64ED6
	for <util-linux@archiver.kernel.org>; Wed,  1 Mar 2023 18:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCASkp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Mar 2023 13:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCASko (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Mar 2023 13:40:44 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D203ECA11
        for <util-linux@vger.kernel.org>; Wed,  1 Mar 2023 10:40:14 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 321IdqoH029043
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 13:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677695993; bh=9dE6FmGN2PDvlgrbWvS+1bg1iO3/pISZzDjR0FnhGI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GSemHxBriOYjtpWEItPKQgn+O1z2wg3GCKKacaCLHmlHvEB6kq4UKTolJYx3S6QRn
         Jvuvx7Xk1oa8aHbudXJN5Kd3crizzB/nX7G0squaYPtTqq7/WdG7uSGFse4wmv5TNy
         0C7yIj8h9vYPAfKtOFSVpbn3OmRZRLxaieS0yoqYeZ3e+Gcvj5XZ5/f02BSofRuUP6
         4XPvtGzaCzTyqYm1iUIBHVHWS4uYDNxEWgoavuvt0h3vccoGYsQjFRVBibBbNImCa5
         i6b2GSFeFsPTHkm8U5k9ZFhkuqa0f8UkZiBIx6SEKRuGlC7U15E+E/gVK90+2fUtxq
         6sjOcqBN121Aw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 655BA15C3593; Wed,  1 Mar 2023 13:39:52 -0500 (EST)
Date:   Wed, 1 Mar 2023 13:39:52 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Chris Hofstaedtler <zeha@debian.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: Move clock.txt to /run
Message-ID: <Y/+b+LlvuaDD4i4k@mit.edu>
References: <20230301140957.21604-1-msuchanek@suse.de>
 <20230301141747.jpbvk4aieq3pdehh@zeha.at>
 <20230301142604.GA19419@kitsune.suse.cz>
 <Y/+CNZZwhbH/rGbX@mit.edu>
 <20230301171759.GB19419@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230301171759.GB19419@kitsune.suse.cz>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 01, 2023 at 06:17:59PM +0100, Michal Suchánek wrote:
> > Using a random number generator for clock can help, but it's only 13
> > bits, so it's certainly not fool-proof.  Given that using a time-based
> > UUID leaks the MAC address of your ethernet port as well as when the
> > UUID was generated (which can be interesting when you're curious say,
> > when a Libreoffice doc was created), in general best practice is to
> > use the random UUID type, especially given that modern Linux systems
> > all have the getrandom(2) system call.  That gives you 58 bits of
> > entropy in the UUID, so that's probably the better way to go.
> 
> That explains why I don't have a clock.txt file. I did not go out of my
> way to generate time-based uuids.

Note that the only reason why you might be trying to generate a huge
number of time-based UUID is if you are running a database (cough,
SAP, cough) that is doing database index compression hacks so they can
use still (a) use UUID's, but (b) not pay the cost of 16-byte UUID for
every single object in their database.

But if they are doing this, you ***really*** want to be using uuidd,
because even using clock.txt in tmpfs, it's going to be *way* faster
to use uuidd, and since some workloads (cough, SAP, cough) are
creating a vast number of UUID's per second while initializing their
database, your distribution users *will* want to install uuidd if they
are using those kinds of Enterprise Resource Planning systems.  If you
consider how much per hour these users pay for their certified
implementation consultsants, it's worth real $$$.   :-)

	       		     	  	     - Ted
