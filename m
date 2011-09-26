Return-Path: dave@gnu.org
Subject: [PATCH 0/5] losetup: rewrite
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Sep 2011 16:49:49 -0300
Message-ID: <1317066589.2896.0.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

This is the first in a number of patchset series to come to rewrite this
tool using the loopdev library. We also aim to add it to the sys-utils/
directory in the attempt to start cleaning up mount/.

Instead of a complete rewrite from scratch, like it was initially
planned, its better to do it incrementally, which makes it easier to
regression test.

Thanks,
Davidlohr 
