Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90DBC64ED6
	for <util-linux@archiver.kernel.org>; Wed,  1 Mar 2023 16:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCAQuS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Mar 2023 11:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjCAQuN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Mar 2023 11:50:13 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7B031E05
        for <util-linux@vger.kernel.org>; Wed,  1 Mar 2023 08:50:11 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 321Gnvgq027000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 11:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677689399; bh=lSWPqbtI9GzudMxeObMK03tyIobPWZaFdyN+UlUSwN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FXGtZEhEWeuV4S1P7pW/emBVM5zQqgH+qhwD84QYnNAkhUbH0EFhVGtw06VloquiH
         uqP78zqtwVXx82CbexSJ8R2nmfppIRWXUqg1nedO5R9RGF2gNlq1Q1WYaDYVgbAoWC
         zWEYNSfvhXWfGqLAcBzxKTAArX6utSMYjJDhhYwdhteVfwj0U61Yt7egdUPbiXNKfu
         o/72St2Hx3QOa5VleSSJIStbmxLCw/KIFV7sN+N5Fsn6JP2fzr2gvfLQjAKc8x0V+G
         NEyeoG/c8KjyIWn7xqVMuFl98Pl8NzIDyGqKb5vTRL9ucTwn1h5S2aE2BL7EmKAHuB
         w13bvBa5yFUwQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B3AAB15C3593; Wed,  1 Mar 2023 11:49:57 -0500 (EST)
Date:   Wed, 1 Mar 2023 11:49:57 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Chris Hofstaedtler <zeha@debian.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: Move clock.txt to /run
Message-ID: <Y/+CNZZwhbH/rGbX@mit.edu>
References: <20230301140957.21604-1-msuchanek@suse.de>
 <20230301141747.jpbvk4aieq3pdehh@zeha.at>
 <20230301142604.GA19419@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230301142604.GA19419@kitsune.suse.cz>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 01, 2023 at 03:26:04PM +0100, Michal Suchánek wrote:
> > Last time I asked about this file on this mailing list, I was
> > informed that clock.txt is supposed to survive reboots.
> > Moving it to /run (or any other tmpfs) would break this.
> 
> What's so valuable in it that it needs to survive?
> 
> I don't have it at all.
> 
> Also the code seems to re-synchronize with the real time clock from time
> to time which makes the content relevant only for limited periods of
> time.

The concern is if the system time goes backwards, this could result in
a duplicative UUID being returned.  This was especially a concern for
systems that were dual-booting with Windows, where Windows set the
real-time clock to localtime, and Linux set the real-time clock to
GMT, and so the real time clock on those systems had a tendency to
bound around a *lot*.

Using a random number generator for clock can help, but it's only 13
bits, so it's certainly not fool-proof.  Given that using a time-based
UUID leaks the MAC address of your ethernet port as well as when the
UUID was generated (which can be interesting when you're curious say,
when a Libreoffice doc was created), in general best practice is to
use the random UUID type, especially given that modern Linux systems
all have the getrandom(2) system call.  That gives you 58 bits of
entropy in the UUID, so that's probably the better way to go.

Cheers,

					- Ted
