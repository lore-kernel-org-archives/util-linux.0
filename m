Return-Path: linux-fsdevel-owner@vger.kernel.org
Subject: fs locks: export informational name
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 28 Jan 2012 16:37:33 +0100
Message-ID: <1327765053.3336.7.camel@offbook>
Mime-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I'm currently rewritting lslk(8) from scratch so we can integrate it in
util-linux, and continue maintaining it.

In order to not break userspace, the kernel is currently exporting the
major:minor numbers of the device where the locked file resides.  Could
we agree on defining WE_CAN_BREAK_LSLK_NOW and start exporting the
informational name instead?

Thanks,
Davidlohr

