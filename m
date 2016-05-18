Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33694 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753040AbcERMbG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 May 2016 08:31:06 -0400
Date: Wed, 18 May 2016 14:31:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Sassan Panahinejad <sassan@sassan.me.uk>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 3/3] sfdisk: Add support for altering GPT size
Message-ID: <20160518123103.v3tdgj4aclg3cc6c@ws.net.home>
References: <1463054083-2485-1-git-send-email-sassan@sassan.me.uk>
 <1463054083-2485-4-git-send-email-sassan@sassan.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463054083-2485-4-git-send-email-sassan@sassan.me.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 12, 2016 at 12:54:43PM +0100, Sassan Panahinejad wrote:
>  libfdisk/src/script.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Applied, thanks.

I have also added "table-length" to the --dump output if table length
is different than the default.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
