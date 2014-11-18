Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60485 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753266AbaKRMBY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Nov 2014 07:01:24 -0500
Date: Tue, 18 Nov 2014 13:01:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] pull: almost working AddressSanitizer support
Message-ID: <20141118120110.GH6704@x2.net.home>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 10, 2014 at 09:49:49PM +0000, Sami Kerola wrote:
>  configure.ac                       | 1 +
>  lib/cpuset.c                       | 1 +
>  libmount/src/utils.c               | 2 +-
>  tests/expected/misc/swaplabel      | 2 +-
>  tests/ts/kill/name_to_number       | 3 +++
>  tests/ts/libmount/tabfiles-py      | 4 ++++
>  tests/ts/libmount/tabfiles-tags    | 4 ++++
>  tests/ts/libmount/tabfiles-tags-py | 4 ++++
>  tests/ts/libmount/update-py        | 6 +++++-
>  9 files changed, 24 insertions(+), 3 deletions(-)

Merged (with one change) from github.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
