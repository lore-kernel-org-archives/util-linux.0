Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47014 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755618Ab3AYQgW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jan 2013 11:36:22 -0500
Date: Fri, 25 Jan 2013 17:36:11 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] some proper pluralization, and a bunch of textual fixes
Message-ID: <20130125163611.GC1954@x2.net.home>
References: <1358956950.25102.140661181364417.13137B26@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358956950.25102.140661181364417.13137B26@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 23, 2013 at 05:02:30PM +0100, Benno Schulenberg wrote:
> The first two patches properly pluralize two error messages.  The third
> patch makes some tiny grammar, style and punctuation tweaks to a few
> error messages.  The fourth marks the filedescriptor as optional for the
> -C option of fsck, and adds some missing markup to the man page, corrects
> a word there, and expands an abbreviation for clarity.  The ninth patch
> then slices the help text of fsck into single options, for ease of
> translation maintenance.  (I hadn't seen Sami's survey request nor its
> results until today -- his request had landed in my spam folder.  :|
> But I fully agree with the outcome.)
> 
> The fifth patch corrects the description of the --sysroot option of lscpu,
> and the tenth patch then slices the text into single options.
> 
> The sixth patch removes the incorrect spaces from "-e [=list]" and
> "-p [=list]" in the lscpu manpage, normalizes the spacing of the text,
> and corrects a word here and there.  The seventh patch normalizes
> the help text of mkfs (using <type> instead of TYPE, for example),
> marks that -t and fs-options are independent (a distinction that has
> gone missing in a commit a year and a half ago), and slices it into
> strips.  The eighth patch standardizes the version reporting to:
> "program from util-linux-x.xx.x".

 It seems that Sami, you and I did the same changes. Please, can you 
 pull from upstream repo and rebase this set of the patches?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
