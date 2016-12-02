Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932520AbcLBMzO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 2 Dec 2016 07:55:14 -0500
Date: Fri, 2 Dec 2016 13:55:06 +0100
From: Karel Zak <kzak@redhat.com>
To: Jim Patterson <jimp@wegrok.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] wall: add --group option
Message-ID: <20161202125506.gufpfzgjo3mwsmnq@ws.net.home>
References: <1479316934-1578-1-git-send-email-jimp@wegrok.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479316934-1578-1-git-send-email-jimp@wegrok.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 16, 2016 at 12:22:14PM -0500, Jim Patterson wrote:
>  bash-completion/wall |  4 +++
>  term-utils/wall.1    |  7 ++++++
>  term-utils/wall.c    | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 79 insertions(+), 1 deletion(-)

Good idea. Applied with some minor changes, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
