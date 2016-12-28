Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34999 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbcL1Uqi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 28 Dec 2016 15:46:38 -0500
Received: by mail-yw0-f195.google.com with SMTP id b66so25488471ywh.2
        for <util-linux@vger.kernel.org>; Wed, 28 Dec 2016 12:46:38 -0800 (PST)
From: The Flying Rapist <impeccableenglish@gmail.com>
Date: Wed, 28 Dec 2016 15:42:37 -0500
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>,
        The Flying Rapist <admin@nosuck.org>
Subject: Re: [PATCH] col: backspacing widechars
Message-ID: <20161228204237.GA29001@creation>
References: <20161228093620.5528-1-ImpeccableEnglish@gmail.com>
 <CAG27Bk1eCMakhnbcmQZpYVvcYF2K+eYSekaQQFxUU5UPXfa2gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <CAG27Bk1eCMakhnbcmQZpYVvcYF2K+eYSekaQQFxUU5UPXfa2gA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2016年12月28日 14時55分, Sami Kerola wrote:
>May I remind howto-contribute[1] tells 'using your real name (sorry,
>no pseudonyms
>or anonymous contributions.)'

I apologize.  I missed that part of howto-contribute.txt.  Please accept the following.

From: Grady Martin <admin@nosuck.org>

Until now, backspace characters have not accounted for characters of widths other than one.  This single line amends that.
---
 text-utils/col.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/col.c b/text-utils/col.c
index 9b0e23058..c63b46fee 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -248,7 +248,7 @@ int main(int argc, char **argv)
                        case BS:                /* can't go back further */
                                if (cur_col == 0)
                                        continue;
-                               --cur_col;
+                               cur_col -= c->c_width;
                                continue;
                        case CR:
                                cur_col = 0;
--
2.11.0
