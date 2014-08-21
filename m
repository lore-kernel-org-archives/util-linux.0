Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48061 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883AbaHUIAf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Aug 2014 04:00:35 -0400
Date: Thu, 21 Aug 2014 10:00:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Robert Bowers <r.bowers@onedingo.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk interactive 'v' usage does not always work
Message-ID: <20140821080021.GF22187@x2.net.home>
References: <20140820151202.79f70dc5@amanda.local.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140820151202.79f70dc5@amanda.local.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 20, 2014 at 03:12:02PM -0400, Robert Bowers wrote:
> It used to print
> Remaining 2047 unallocated 512-byte sectors.
> for a layout like this but now prints nothing.

And it it problem?

This is expected behavior, the sectors before the first partition are no more
reported as unused. The space is usually ignored to keep the first partition
aligned, to have a space for boot loaders, etc. (But you can still move the 
partition in expert menu.)

The original behavior was also inconsistent with "First sector" dialog
where the first sector is usually 2048. It's strange when the "verify"
function reports (expected and wanted) gaps in the default layout.

See commit 11712b6667225ef6fa6b64c1fe48ed5b501ad72e.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
