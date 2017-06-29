Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:60451 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751553AbdF2AqE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 20:46:04 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] misc: standardize USAGE_COLUMNS
Date: Thu, 29 Jun 2017 02:45:50 +0200
Cc: util-linux@vger.kernel.org
References: <1621510c-227f-325b-7867-c305f738174a@gmx.com> <201706290227.35921.sweet_f_a@gmx.de>
In-Reply-To: <201706290227.35921.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201706290245.50496.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 29 June 2017, Ruediger Meier wrote:
> On Thursday 29 June 2017 at 00:44, you wrote:

> "columns to display (see Columns:)"

Another point. This is the SHORT help. Maybe it's too much that
2 of 3 nouns are the same.

Better:

  "COLUMNS to display (see below)"

where "(see below)" could be skipped as mentioned.

or just inlined

  "output columns (gpt, dos, bsd, sgi, sun)"

cu,
Rudi
