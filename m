Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:33358 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030639AbbD1OQC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Apr 2015 10:16:02 -0400
Date: Tue, 28 Apr 2015 10:15:58 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Karel Zak <kzak@redhat.com>
Cc: Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org
Subject: Re: [PATCH] fsck: implement fsck -r {fd}
Message-ID: <20150428141558.GA2569@thunk.org>
References: <553E53D7.8020800@suse.cz>
 <20150428115210.GW27969@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150428115210.GW27969@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 28, 2015 at 01:52:10PM +0200, Karel Zak wrote:
> 
> On Mon, Apr 27, 2015 at 05:20:55PM +0200, Stanislav Brabec wrote:
> > Note: Code in if and else is intentionally partially duplicated. Current
> > human readable output of floats does not conform to locale conventions,
> > and may be changed in future. But we want to keep machine readable output
> > exactly same as it is now.
> 
> The question is if we can change the human readable output. It was
> requested by Google and I guess they parse the output.

We're not parsing the output; it's something that we look at in the
log files manually (i.e., by humans when trying to debug a problem.)

The bigger deal for us not just mixing the stats and the rest of the
fsck output, but if you have dozen(s) of disks after a power failure,
and you're running without a journal, multiple drives will have
inconsistencies that need fixing, and so we divert the output for each
fsck process to a separate log file for each fsck process / file
system.

The changes to separate out the fsck output into separate files is a
change which I don't think ever made it upstream.  IIRC, we submitted
the patches upstream, there were some objections, and I never had time
to get back to trying to make something that would work for us and
acceptable upstream; my bad.  If you want I can try to dig it up and
try resubmitting it.

Alternatively, upstream e2fsck also has a way of having e2fsck direct
its output to individual files, which is a bit more flexible and IMO a
bit cleaner than the fsck changes.  I suspect the right answer is to
get something like this into fsck, but the problem is where to put the
formatting information, since fsck doesn't a configuration file ala
/etc/e2fsck.conf, where something like this can be dropped:

[options]
    log_dir = /var/log/fsck
    log_filename = e2fsck-%N.%h.%D-%T
    log_dir_wait = true
    report_time = true
    report_verbose = true
    report_features = true

See the man page for e2fsck.conf, looking at the LOGGING section and
the definition of log_* in the options configuration stanza for more
details.

If I recall correctly, it was the fact that fsck didn't have a
configuration file which made the fsck patches a bit grotty, since
there was no place to put the information to customize the logging
output, and it's highly likely that what would work for Google might
not be all that acceptable for other sites.  That's why I ended up
coding the e2fsck changes, but we never got around to switching over,
since our out-of-tree fsck patches worked well enough, even if they
could never go upstream.  I can try resending the fsck patches, but I
wouldn't blame you if you considered them too ugly to live.

Let me know if you have preferences of how you would like to proceed.

Cheers,

					- Ted
