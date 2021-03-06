MJ_PATH := $(HOME)/.mujoco/mujoco200_linux
EIGEN_PATH := $(HOME)/Eigen

INC		:= -Iinclude -I$(MJ_PATH)/include -I$(EIGEN_PATH) -L$(MJ_PATH)/bin $(MJ_PATH)/bin/libglfw.so.3

CFLAGS	:= -Wall -Wextra -O3 -std=c++11 -pthread -Wl,-rpath,$(MJ_PATH)/bin
LDFLAGS	:= -shared -Lsrc

CC 		:= g++
LIBS	:= -lmujoco200 -lGL -lglew 

default:
	$(CC) $(CFLAGS) testSim.cpp src/ik.cpp src/mujSimulation.cpp $(INC) $(LIBS) -o testSim.out
	$(CC) -c src/ik.cpp $(CFLAGS) $(INC) $(LIBS) -fPIC -o ik.o
	$(CC) -c src/mujSimulation.cpp $(CFLAGS) $(INC) $(LIBS) -fPIC -o mujsimulation.o

libcassieik:
	$(CC) -shared -o libcassieik.so mujsimulation.o ik.o $(CFLAGS) $(INC) $(LIBS)

all: default libcassieik

clean:
	rm -f testSim.out libcassieik.so ik.o mujsimulation.o