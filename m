Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752039AbdLDMFo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 4 Dec 2017 07:05:44 -0500
Date: Mon, 4 Dec 2017 13:05:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] rename: use access(3) to check if a file exists
Message-ID: <20171204120541.rirorcgyei3fcuuo@ws.net.home>
References: <20171203125117.28159-1-kerolasa@iki.fi>
 <20171203125117.28159-2-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171203125117.28159-2-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 03, 2017 at 12:51:15PM +0000, Sami Kerola wrote:
>  misc-utils/rename.c             |  3 +--
>  tests/expected/rename/overwrite |  1 +
>  tests/ts/rename/overwrite       | 31 +++++++++++++++++++++++++++++++

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
