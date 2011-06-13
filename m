Return-Path: rjones@redhat.com
Date: Mon, 13 Jun 2011 18:05:42 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: kzak@redhat.com, util-linux@vger.kernel.org
Subject: [PATCH] blkid: Don't ignore swap UUID if only first byte is zero.
Message-ID: <20110613170541.GY28762@amd.home.annexia.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
List-ID: <util-linux.vger.kernel.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


We found that if you use 'mkswap -U' option with a UUID with the first
byte zero (ie. any UUID starting 00....) then blkid was not able to
"see" the UUID.

For example:

  # mkswap -f -U 00c1bbe9-cd0f-17a6-bb14-b21cdf0a458b /dev/vda1
  Setting up swapspace version 1, size = 1047548 KiB
  no label, UUID=00c1bbe9-cd0f-17a6-bb14-b21cdf0a458b
  # blkid -o value -s UUID /dev/vda1

[no output from blkid command above, but ...]

  # mkswap -f -U 11c1bbe9-cd0f-17a6-bb14-b21cdf0a458b /dev/vda1
  Setting up swapspace version 1, size = 1047548 KiB
  no label, UUID=11c1bbe9-cd0f-17a6-bb14-b21cdf0a458b
  # blkid -o value -s UUID /dev/vda1
  11c1bbe9-cd0f-17a6-bb14-b21cdf0a458b

Even worse, mkswap without -U option will sometimes randomly choose a
UUID starting with 00... which blkid fails to read.  You can test this
by running a loop with mkswap / blkid.  After an expected ~100 runs,
you will see a UUID written by mkswap that blkid cannot read.

I verified that UUIDs starting with 00... are in fact written to the
swap device itself.  However I'm still not exactly clear if such UUIDs
are valid.  Nevertheless, the attached patch makes it so that blkid
can see such UUIDs, assuming that they are valid.

I tested this by patching Fedora 15 libblkid and running the test
above.  With this patch, the blkid command was able to see the UUID
written by mkswap -U.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into Xen guests.
http://et.redhat.com/~rjones/virt-p2v

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-blkid-Don-t-ignore-swap-UUID-if-only-first-byte-is-z.patch"

>From cee5d4660b3425cfba366353102785a35265c7c4 Mon Sep 17 00:00:00 2001
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Mon, 13 Jun 2011 17:43:11 +0100
Subject: [PATCH] blkid: Don't ignore swap UUID if only first byte is zero.

---
 libblkid/src/superblocks/swap.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/libblkid/src/superblocks/swap.c b/libblkid/src/superblocks/swap.c
index 325a8fa..129eafa 100644
--- a/libblkid/src/superblocks/swap.c
+++ b/libblkid/src/superblocks/swap.c
@@ -39,6 +39,7 @@ struct swap_header_v1_2 {
 static int swap_set_info(blkid_probe pr, const char *version)
 {
 	struct swap_header_v1_2 *hdr;
+	static const unsigned char zero_uuid[16];
 
 	/* Swap header always located at offset of 1024 bytes */
 	hdr = (struct swap_header_v1_2 *) blkid_probe_get_buffer(pr, 1024,
@@ -56,7 +57,8 @@ static int swap_set_info(blkid_probe pr, const char *version)
 		if (hdr->volume[0] && blkid_probe_set_label(pr, hdr->volume,
 				sizeof(hdr->volume)) < 0)
 			return -1;
-		if (hdr->uuid[0] && blkid_probe_set_uuid(pr, hdr->uuid) < 0)
+		if (memcmp (hdr->uuid, zero_uuid, sizeof zero_uuid) != 0
+		    && blkid_probe_set_uuid(pr, hdr->uuid) < 0)
 			return -1;
 	}
 
-- 
1.7.5.2


--YiEDa0DAkWCtVeE4--
