BASE_DIR = .
SRC_DIR = $(BASE_DIR)/src
MISC_DIR = $(BASE_DIR)/misc

# CC = gcc
CFLAGS = -c -O2 -Wall # -ggdb -Wextra
LDFLAGS = -lzmq -lczmq -ljansson

SYSTEMD_LDFLAGS = -lsystemd

default: journal-gateway-zmtp-source journal-gateway-zmtp-sink

source: journal-gateway-zmtp-source
sink: journal-gateway-zmtp-sink

journal-gateway-zmtp-source: journal-gateway-zmtp-source.o
	$(CC) journal-gateway-zmtp-source.o $(LDFLAGS) $(SYSTEMD_LDFLAGS) -o journal-gateway-zmtp-source

journal-gateway-zmtp-source.o: $(SRC_DIR)/journal-gateway-zmtp-source.c
	$(CC) $(CFLAGS) $(SRC_DIR)/journal-gateway-zmtp-source.c -o journal-gateway-zmtp-source.o

journal-gateway-zmtp-sink: journal-gateway-zmtp-sink.o
	$(CC) journal-gateway-zmtp-sink.o $(LDFLAGS) $(SYSTEMD_LDFLAGS) -o journal-gateway-zmtp-sink

journal-gateway-zmtp-sink.o: $(SRC_DIR)/journal-gateway-zmtp-sink.c
	$(CC) $(CFLAGS) $(SRC_DIR)/journal-gateway-zmtp-sink.c -o journal-gateway-zmtp-sink.o

clean:
	rm -f *.o journal-gateway-zmtp-source journal-gateway-zmtp-sink
