Return-Path: util-linux-owner@vger.kernel.org
Received: from li9-11.members.linode.com ([67.18.176.11]:55877 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759465Ab2C2V3P (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 17:29:15 -0400
Date: Thu, 29 Mar 2012 14:29:11 -0700
From: "Ted Ts'o" <tytso@mit.edu>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/20] uuidd: make drop_privs true by default in main()
Message-ID: <20120329212911.GB13970@thunk.org>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
 <1333039528-24784-11-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333039528-24784-11-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 29, 2012 at 06:45:18PM +0200, Petr Uzel wrote:
> The drop_privs variable in main() was used to determine whether the
> daemon will attempt to drop privileges (provided it has been installed
> suid). As of now, it makes sense to drop the privileges each time it is
> started. Therefore, this patch inverts the default value of drop_privs
> to true, so that it does not need to be set in the getopt loop at
> multiple places.
> 
> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>

This breaks the configuration where libuuid starts uuidd if it's not
available, since there the user process probably doesn't have access
to write to /var/lib/libuuid/clock.txt, and so dropping the setgid
privileges of uuid will cause it not to work.

Also, if you're going to have a -K option to keep the privileges,
there isn't much of a security benefit, since if there's a bug in
uuidd, the attacker can always call uuidd with -K and and then attempt
to exploint any problem that might be there.

So it's not clear adding the ability to drop privileges is really all
that functional; if uuidd is setuid/setgid, it's probably because it
**needs** those privileges.

						- Ted
