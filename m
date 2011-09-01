Return-Path: util-linux-owner@vger.kernel.org
Received: from odpn1.odpn.net ([212.40.96.53]:56583 "EHLO odpn1.odpn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab1IAJaD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 1 Sep 2011 05:30:03 -0400
From: "Gabor Z. Papp" <gzp@papp.hu>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: dmesg(1) bug
References: <20110831104859.GB1547@nb.net.home>
Date: Thu, 01 Sep 2011 11:14:05 +0200
Message-ID: <x6zkiopqua@gzp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--=-=-=

* Karel Zak <kzak@redhat.com>:

|  There is a bug in the new dmesg(1) code, affected are systems without
|  CONFIG_PRINTK_TIME and maybe some very old systems with kernel <= 2.6.16.
|  The problem is that dmesg incorrectly works with empty lines (e.g. "<6>\n").

After patching dmesg, there is still difference between the old 2.19.x
and the new 2.20 output.

Is that normal?


--=-=-=
Content-Type: text/x-patch; charset=utf-8
Content-Disposition: inline; filename=dmesg.diff
Content-Transfer-Encoding: 8bit

--- dmesg.old	2011-09-01 11:10:17.810668299 +0200
+++ dmesg.new	2011-09-01 11:10:22.852668385 +0200
@@ -1,45 +1,45 @@
 Linux version 2.6.32.46-gzp1 (root@gzp1) (gcc version 4.4.6 (GCC) ) #1 SMP PREEMPT Tue Aug 30 13:20:58 CEST 2011
 KERNEL supported cpus:
-  Intel GenuineIntel
-  AMD AuthenticAMD
-  NSC Geode by NSC
-  Cyrix CyrixInstead
-  Centaur CentaurHauls
-  Transmeta GenuineTMx86
-  Transmeta TransmetaCPU
-  UMC UMC UMC UMC
+ Intel GenuineIntel
+ AMD AuthenticAMD
+ NSC Geode by NSC
+ Cyrix CyrixInstead
+ Centaur CentaurHauls
+ Transmeta GenuineTMx86
+ Transmeta TransmetaCPU
+ UMC UMC UMC UMC
 BIOS-provided physical RAM map:
- BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
- BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
- BIOS-e820: 00000000000e5000 - 0000000000100000 (reserved)
- BIOS-e820: 0000000000100000 - 000000007ff40000 (usable)
- BIOS-e820: 000000007ff40000 - 000000007ff4e000 (ACPI data)
- BIOS-e820: 000000007ff4e000 - 000000007ffe0000 (ACPI NVS)
- BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
- BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
- BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
+BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
+BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
+BIOS-e820: 00000000000e5000 - 0000000000100000 (reserved)
+BIOS-e820: 0000000000100000 - 000000007ff40000 (usable)
+BIOS-e820: 000000007ff40000 - 000000007ff4e000 (ACPI data)
+BIOS-e820: 000000007ff4e000 - 000000007ffe0000 (ACPI NVS)
+BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
+BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
+BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
 DMI 2.4 present.
 last_pfn = 0x7ff40 max_arch_pfn = 0x100000
 MTRR default type: uncachable
 MTRR fixed ranges enabled:
-  00000-9FFFF write-back
-  A0000-DFFFF uncachable
-  E0000-EFFFF write-through
-  F0000-FFFFF write-protect
+ 00000-9FFFF write-back
+ A0000-DFFFF uncachable
+ E0000-EFFFF write-through
+ F0000-FFFFF write-protect
 MTRR variable ranges enabled:
-  0 base 000000000 mask F80000000 write-back
-  1 disabled
-  2 disabled
-  3 disabled
-  4 disabled
-  5 disabled
-  6 disabled
-  7 disabled
+ 0 base 000000000 mask F80000000 write-back
+ 1 disabled
+ 2 disabled
+ 3 disabled
+ 4 disabled
+ 5 disabled
+ 6 disabled
+ 7 disabled
 initial memory mapped : 0 - 01800000
 init_memory_mapping: 0000000000000000-00000000377fe000
- 0000000000 - 0000400000 page 4k
- 0000400000 - 0037400000 page 2M
- 0037400000 - 00377fe000 page 4k
+0000000000 - 0000400000 page 4k
+0000400000 - 0037400000 page 2M
+0037400000 - 00377fe000 page 4k
 kernel direct mapping tables up to 377fe000 @ 7000-c000
 ACPI: RSDP 000f9ee0 00024 (v02 ACPIAM)
 ACPI: XSDT 7ff40100 0004C (v01 A_M_I_ OEMXSDT  10000801 MSFT 00000097)
@@ -53,36 +53,36 @@
 ACPI: Local APIC address 0xfee00000
 1159MB HIGHMEM available.
 887MB LOWMEM available.
-  mapped low ram: 0 - 377fe000
-  low ram: 0 - 377fe000
-  node 0 low ram: 00000000 - 377fe000
-  node 0 bootmap 00008000 - 0000ef00
+ mapped low ram: 0 - 377fe000
+ low ram: 0 - 377fe000
+ node 0 low ram: 00000000 - 377fe000
+ node 0 bootmap 00008000 - 0000ef00
 (8 early reservations) ==> bootmem [0000000000 - 00377fe000]
-  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
-  #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 - 0000002000]
-  #2 [0000006000 - 0000007000]       TRAMPOLINE ==> [0000006000 - 0000007000]
-  #3 [0001000000 - 00013f0174]    TEXT DATA BSS ==> [0001000000 - 00013f0174]
-  #4 [000009f000 - 0000100000]    BIOS reserved ==> [000009f000 - 0000100000]
-  #5 [00013f1000 - 00013f7230]              BRK ==> [00013f1000 - 00013f7230]
-  #6 [0000007000 - 0000008000]          PGTABLE ==> [0000007000 - 0000008000]
-  #7 [0000008000 - 000000f000]          BOOTMAP ==> [0000008000 - 000000f000]
+ #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
+ #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 - 0000002000]
+ #2 [0000006000 - 0000007000]       TRAMPOLINE ==> [0000006000 - 0000007000]
+ #3 [0001000000 - 00013f0174]    TEXT DATA BSS ==> [0001000000 - 00013f0174]
+ #4 [000009f000 - 0000100000]    BIOS reserved ==> [000009f000 - 0000100000]
+ #5 [00013f1000 - 00013f7230]              BRK ==> [00013f1000 - 00013f7230]
+ #6 [0000007000 - 0000008000]          PGTABLE ==> [0000007000 - 0000008000]
+ #7 [0000008000 - 000000f000]          BOOTMAP ==> [0000008000 - 000000f000]
 Zone PFN ranges:
-  DMA      0x00000000 -> 0x00001000
-  Normal   0x00001000 -> 0x000377fe
-  HighMem  0x000377fe -> 0x0007ff40
+ DMA      0x00000000 -> 0x00001000
+ Normal   0x00001000 -> 0x000377fe
+ HighMem  0x000377fe -> 0x0007ff40
 Movable zone start PFN for each node
 early_node_map[2] active PFN ranges
-    0: 0x00000000 -> 0x0000009f
-    0: 0x00000100 -> 0x0007ff40
+   0: 0x00000000 -> 0x0000009f
+   0: 0x00000100 -> 0x0007ff40
 On node 0 totalpages: 523999
 free_area_init_node: node 0, pgdat c12fc500, node_mem_map c13f9000
-  DMA zone: 32 pages used for memmap
-  DMA zone: 0 pages reserved
-  DMA zone: 3967 pages, LIFO batch:0
-  Normal zone: 1744 pages used for memmap
-  Normal zone: 221486 pages, LIFO batch:31
-  HighMem zone: 2319 pages used for memmap
-  HighMem zone: 294451 pages, LIFO batch:31
+ DMA zone: 32 pages used for memmap
+ DMA zone: 0 pages reserved
+ DMA zone: 3967 pages, LIFO batch:0
+ Normal zone: 1744 pages used for memmap
+ Normal zone: 221486 pages, LIFO batch:31
+ HighMem zone: 2319 pages used for memmap
+ HighMem zone: 294451 pages, LIFO batch:31
 Using APIC driver default
 ACPI: PM-Timer IO Port: 0x808
 ACPI: Local APIC address 0xfee00000
@@ -120,13 +120,13 @@
 Initializing HighMem for node 0 (000377fe:0007ff40)
 Memory: 2073580k/2096384k available (2253k kernel code, 21388k reserved, 812k data, 308k init, 1187080k highmem)
 virtual kernel memory layout:
-    fixmap  : 0xfff91000 - 0xfffff000   ( 440 kB)
-    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
-    vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
-    lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
-      .init : 0xc12ff000 - 0xc134c000   ( 308 kB)
-      .data : 0xc1233489 - 0xc12fe838   ( 812 kB)
-      .text : 0xc1000000 - 0xc1233489   (2253 kB)
+   fixmap  : 0xfff91000 - 0xfffff000   ( 440 kB)
+   pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
+   vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
+   lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
+     .init : 0xc12ff000 - 0xc134c000   ( 308 kB)
+     .data : 0xc1233489 - 0xc12fe838   ( 812 kB)
+     .text : 0xc1000000 - 0xc1233489   (2253 kB)
 Checking if this processor honours the WP bit even in supervisor mode...Ok.
 SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
 Hierarchical RCU implementation.
@@ -377,8 +377,8 @@
 pcieport 0000:04:01.0: setting latency timer to 64
 aic7xxx 0000:01:00.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
 scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
-        <Adaptec 29160 Ultra160 SCSI adapter>
-        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
+       <Adaptec 29160 Ultra160 SCSI adapter>
+       aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
 
 scsi 0:0:0:0: Direct-Access     SEAGATE  ST373207LW       0003 PQ: 0 ANSI: 3
 scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
@@ -432,14 +432,14 @@
 cpuidle: using governor menu
 TCP cubic registered
 Using IPI Shortcut mode
- sdb:
+sdb:
 sd 0:0:0:0: [sda] 143374744 512-byte logical blocks: (73.4 GB/68.3 GiB)
 sd 0:0:0:0: [sda] Write Protect is off
 sd 0:0:0:0: [sda] Mode Sense: ab 00 10 08
 sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
- sda: sda1 sda2
+sda: sda1 sda2
 sd 0:0:0:0: [sda] Attached SCSI disk
- unknown partition table
+unknown partition table
 sd 1:0:0:0: [sdb] Very big device. Trying to use READ CAPACITY(16).
 sd 1:0:0:0: [sdb] Attached SCSI disk
 input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
@@ -559,11 +559,11 @@
 e1000e 0000:02:00.0: irq 30 for MSI/MSI-X
 usb 1-1: New USB device found, idVendor=045e, idProduct=001e
 usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
-usb 1-1: Product: Microsoft IntelliMouse® Explorer
+usb 1-1: Product: Microsoft IntelliMouse\xffffffc2\xffffffae Explorer
 usb 1-1: Manufacturer: Microsoft
 usb 1-1: configuration #1 chosen from 1 choice
-input: Microsoft Microsoft IntelliMouse® Explorer as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1:1.0/input/input1
-generic-usb 0003:045E:001E.0001: input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-0000:00:1d.0-1/input0
+input: Microsoft Microsoft IntelliMouse\xffffffc2\xffffffae Explorer as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1:1.0/input/input1
+generic-usb 0003:045E:001E.0001: input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse\xffffffc2\xffffffae Explorer] on usb-0000:00:1d.0-1/input0
 e1000e 0000:02:00.0: irq 30 for MSI/MSI-X
 e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
 i801_smbus 0000:00:1f.3: PCI INT B -> GSI 23 (level, low) -> IRQ 23

--=-=-=
Content-Type: text/x-patch; charset=utf-8
Content-Disposition: inline; filename=dmesg-raw.diff
Content-Transfer-Encoding: 8bit

--- dmesg-raw.old	2011-09-01 11:11:52.268668368 +0200
+++ dmesg-raw.new	2011-09-01 11:11:44.432668343 +0200
@@ -559,11 +559,11 @@
 <7>e1000e 0000:02:00.0: irq 30 for MSI/MSI-X
 <6>usb 1-1: New USB device found, idVendor=045e, idProduct=001e
 <6>usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
-<6>usb 1-1: Product: Microsoft IntelliMouse® Explorer
+<6>usb 1-1: Product: Microsoft IntelliMouse\xffffffc2\xffffffae Explorer
 <6>usb 1-1: Manufacturer: Microsoft
 <6>usb 1-1: configuration #1 chosen from 1 choice
-<6>input: Microsoft Microsoft IntelliMouse® Explorer as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1:1.0/input/input1
-<6>generic-usb 0003:045E:001E.0001: input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-0000:00:1d.0-1/input0
+<6>input: Microsoft Microsoft IntelliMouse\xffffffc2\xffffffae Explorer as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1:1.0/input/input1
+<6>generic-usb 0003:045E:001E.0001: input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse\xffffffc2\xffffffae Explorer] on usb-0000:00:1d.0-1/input0
 <7>e1000e 0000:02:00.0: irq 30 for MSI/MSI-X
 <6>e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
 <6>i801_smbus 0000:00:1f.3: PCI INT B -> GSI 23 (level, low) -> IRQ 23

--=-=-=--
